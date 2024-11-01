# This python script will scan a txt file of URLs and validate their SSL cert and expiration dates.  If the cert is set to expire within 90 days (or whatever you choose), it will send an alert to a Teams channel of your choice.
# For more information please see: 

import socket
import ssl
import datetime
import requests

# Define your path to the URL file
urls_file = "/Users/daveherrell/Desktop/urls.txt"

# Define the Teams Webhook URL you created
teams_webhook_url = "YOURTEAMSWEBHOOKURLHERE"

# Set the number of days to check for certificate expiration
warning_days = 90

# Function to fetch SSL certificate information
def get_ssl_certificate_info(url):
    try:
        hostname = url.replace("https://", "").replace("http://", "").split("/")[0]
        context = ssl.create_default_context()
        
        with socket.create_connection((hostname, 443)) as sock:
            with context.wrap_socket(sock, server_hostname=hostname) as ssock:
                cert = ssock.getpeercert()
        
        not_after = datetime.datetime.strptime(cert['notAfter'], "%b %d %H:%M:%S %Y %Z")
        issuer = dict(x[0] for x in cert['issuer'])['organizationName']
        registrar = cert.get('subjectAltName', [(None, hostname)])[0][1]
        
        return {
            "url": url,
            "issuer": issuer,
            "not_after": not_after,
            "registrar": registrar,
            "is_valid": True
        }
    except Exception as e:
        print(f"Failed to fetch certificate for {url}: {e}")
        return None

# Function to send a notification to Teams
def send_teams_notification(message):
    payload = {
        "@type": "MessageCard",
        "@context": "http://schema.org/extensions",
        "summary": "SSL Certificate Expiry Alert",
        "themeColor": "FF0000",
        "title": "SSL Certificate Expiry Alert",
        "text": message
    }
    
    response = requests.post(teams_webhook_url, json=payload)
    if response.status_code != 200:
        print(f"Failed to send Teams message: {response.status_code}, {response.text}")

# Read URLs from file and process each
try:
    with open(urls_file, "r") as f:
        urls = [line.strip() for line in f if line.strip()]

    for url in urls:
        cert_info = get_ssl_certificate_info(url)
        if cert_info and cert_info["is_valid"]:
            days_to_expire = (cert_info["not_after"] - datetime.datetime.utcnow()).days
            if days_to_expire <= warning_days:
                message = (
                    f"SSL Certificate for {cert_info['url']} issued by {cert_info['issuer']} "
                    f"(Registrar: {cert_info['registrar']}) will expire in {days_to_expire} days "
                    f"on {cert_info['not_after'].strftime('%Y-%m-%d')}."
                )
                send_teams_notification(message)
                print(message)
        else:
            print(f"Invalid certificate for {url} or unable to retrieve certificate.")
except FileNotFoundError:
    print(f"URLs file not found at {urls_file}")
