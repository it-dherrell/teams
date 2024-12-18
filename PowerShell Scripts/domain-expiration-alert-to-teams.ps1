#Script to scan a text file list of domain names and post 30 days expiring domains to a Microsoft Teams Channel. 
#For more information check out https://www.daveherrell.com/microsoft-teams-slack-alerts-for-expiring-domain-names/

# Define file paths and Teams webhook
$domainFile = "/Users/daveherrell/Desktop/domains.txt" #update this with the location of your txt file.
$webhookUrl = "YOUR SUPER COOL TEAMS WEBHOOK URL"  #Webhook URL created for your specific Teams channel.

# Function to get expiration details for a domain
function Get-DomainExpirationDetails {
    param (
        [string]$Domain
    )

    try {
        # Get WHOIS data for the domain
        $whoisInfo = whois $Domain | Out-String

        # Parse the registrar information from WHOIS info
        if ($whoisInfo -match "Registrar: (.+)") {
            $registrar = $matches[1].Trim()
        } elseif ($whoisInfo -match "Sponsoring Registrar: (.+)") {
            $registrar = $matches[1].Trim()
        } else {
            $registrar = "Unknown"
        }

        # Parse expiration date based on typical patterns for .org and other domains
        if ($whoisInfo -match "Expiration Date: (\d{4}-\d{2}-\d{2})") {
            $expirationDate = [datetime]::ParseExact($matches[1], "yyyy-MM-dd", $null)
        } elseif ($whoisInfo -match "Registry Expiry Date: (\d{4}-\d{2}-\d{2})") {
            $expirationDate = [datetime]::ParseExact($matches[1], "yyyy-MM-dd", $null)
        } else {
            Write-Host "Could not retrieve expiration date for $Domain" -ForegroundColor Yellow
            return $null
        }

        # Calculate days until expiration
        $daysUntilExpiration = ($expirationDate - (Get-Date)).Days
        return [PSCustomObject]@{
            Domain              = $Domain
            ExpirationDate      = $expirationDate
            DaysUntilExpiration = $daysUntilExpiration
            Registrar           = $registrar
        }
    } catch {
        Write-Host "Error retrieving WHOIS for $Domain" -ForegroundColor Red
        return $null
    }
}

# Initialize list for expiring domains
$expiringDomains = @()

# Read domains from file and get expiration details
foreach ($domain in Get-Content -Path $domainFile) {
    $domain = $domain.Trim()
    if ($domain) {
        $details = Get-DomainExpirationDetails -Domain $domain
        if ($details -and $details.DaysUntilExpiration -le 30) {
            $expiringDomains += $details
        }
    }
}

# Format and send to Microsoft Teams if any domains are expiring soon
if ($expiringDomains.Count -gt 0) {
    $messageText = "**The following domains are expiring within 30 days:**`n"
    foreach ($domain in $expiringDomains) {
        $messageText += "`n**Domain**: $($domain.Domain)`n**Expiration Date:** $($domain.ExpirationDate.ToString('yyyy-MM-dd'))`n**Days Until Expiration:** $($domain.DaysUntilExpiration)`n**Registrar:** $($domain.Registrar)`n"
    }

    # Prepare JSON payload
    $payload = @{
        text = $messageText
    } | ConvertTo-Json -Depth 3

    # Send POST request to Teams webhook
    try {
        Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType 'application/json'
        Write-Host "Notification sent to Microsoft Teams." -ForegroundColor Green
    } catch {
        Write-Host "Failed to send notification to Microsoft Teams." -ForegroundColor Red
    }
} else {
    Write-Host "No domains expiring within 30 days." -ForegroundColor Cyan
}
