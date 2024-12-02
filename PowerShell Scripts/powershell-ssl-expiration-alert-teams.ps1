# This Powershell script scans a text file of URLs to validate and review their SSL certificates.  If the SSL cert is set to expire in the time frame you set (default 30 days), it will then send and alert to your Teams Channel.
# For more information please see: https://www.daveherrell.com/powershell-send-ssl-cert-expirations-to-teams/

# Define the path to your the URL file
$urlsFile = "/Users/daveherrell/Desktop/urls.txt"

# Make sure you define the Teams Webhook URL
$teamsWebhookUrl = "YOUR TEAMS URL GOES HERE"

# Set the number of days to check for certificate expiration
$warningDays = 30

# Function to fetch SSL certificate information
function Get-SSLCertificateInfo {
    param (
        [string]$url
    )

    try {
        $uri = New-Object System.Uri($url)
        $tcpClient = New-Object System.Net.Sockets.TcpClient
        $tcpClient.Connect($uri.Host, 443)
        $sslStream = New-Object System.Net.Security.SslStream($tcpClient.GetStream(), $false, ({ $true }))
        $sslStream.AuthenticateAsClient($uri.Host)

        $cert = $sslStream.RemoteCertificate
        $cert2 = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $cert
        $tcpClient.Close()

        return @{
            Url = $url
            Issuer = $cert2.Issuer
            NotAfter = $cert2.NotAfter
            Registrar = $cert2.GetNameInfo([System.Security.Cryptography.X509Certificates.X509NameType]::DnsName, $false)
            IsValid = $cert2.Verify()
        }
    } catch {
        Write-Output "Failed to fetch certificate for $url"
        return $null
    }
}

# Function to send notification to Microsoft Teams
function Send-TeamsNotification {
    param (
        [string]$message
    )

    $payload = @{
        "@type"       = "MessageCard"
        "@context"    = "http://schema.org/extensions"
        "summary"     = "SSL Certificate Expiry Alert"
        "themeColor"  = "FF0000"
        "title"       = "SSL Certificate Expiry Alert"
        "text"        = $message
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $teamsWebhookUrl -Method Post -ContentType 'application/json' -Body $payload
    if ($response.StatusCode -ne 200) {
        Write-Output "Failed to send Teams message: $($response.StatusCode), $($response.Content)"
    }
}

# Read URLs from file
if (Test-Path $urlsFile) {
    $urls = Get-Content -Path $urlsFile
    foreach ($url in $urls) {
        $certInfo = Get-SSLCertificateInfo -url $url
        if ($certInfo -ne $null -and $certInfo.IsValid) {
            $daysToExpire = ($certInfo.NotAfter - (Get-Date)).Days
            if ($daysToExpire -le $warningDays) {
                $message = "SSL Certificate for $($certInfo.Url) issued by $($certInfo.Issuer) (Registrar: $($certInfo.Registrar)) will expire in $daysToExpire days on $($certInfo.NotAfter)."
                Send-TeamsNotification -message $message
                Write-Output $message
            }
        } else {
            Write-Output "Invalid certificate for $url or unable to retrieve certificate."
        }
    }
} else {
    Write-Output "URLs file not found at $urlsFile"
}
