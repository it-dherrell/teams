#This Python script will scan a list of domain names from a txt file, checks to see which ones will expire within 30 days and sends an alert into your Microsoft Teams Channel.
#For more information on this script please see https://www.daveherrell.com/python-teams-alerts-for-expiring-domain-names/

import whois
from datetime import datetime, timedelta
import requests
import json

# Make sure you creat your Microsoft Teams webhook URL
TEAMS_WEBHOOK_URL = "YOUR AWESOME MICROSOFT TEAMS WEBHOOK URL HERE"

# Function to send message to Microsoft Teams
def send_to_teams(message):
    headers = {"Content-Type": "application/json"}
    payload = {"text": message}
    response = requests.post(TEAMS_WEBHOOK_URL, headers=headers, data=json.dumps(payload))
    if response.status_code != 200:
        print(f"Failed to send message to Teams: {response.status_code}, {response.text}")
    else:
        print("Message sent to Teams successfully")

# Function to check domain expiration and return details
def check_domain_expiration(domain):
    try:
        domain_info = whois.whois(domain)
        expiration_date = domain_info.expiration_date
        registrar = domain_info.registrar

        # Some WHOIS data return a list for expiration_date
        if isinstance(expiration_date, list):
            expiration_date = expiration_date[0]

        if expiration_date:
            days_until_expiration = (expiration_date - datetime.now()).days
            if days_until_expiration <= 30:
                return {
                    "domain": domain,
                    "expiration_date": expiration_date.strftime('%Y-%m-%d'),
                    "days_until_expiration": days_until_expiration,
                    "registrar": registrar
                }
    except Exception as e:
        print(f"Error fetching WHOIS for {domain}: {e}")
    return None

# Main function
def main():
    with open("/Users/daveherrell/Desktop/domains.txt", "r") as file:   #make sure you update this path with your txt file path.
        domains = file.readlines()
    
    message = "**Domains expiring within 30 days:**\n"
    has_expiring_domains = False

    for domain in domains:
        domain = domain.strip()
        domain_details = check_domain_expiration(domain)
        if domain_details:
            has_expiring_domains = True
            message += (
                f"- **Domain**: {domain_details['domain']}\n"
                f"  - **Expiration Date**: {domain_details['expiration_date']}\n"
                f"  - **Days Until Expiration**: {domain_details['days_until_expiration']} days\n"
                f"  - **Registrar**: {domain_details['registrar']}\n\n"
            )
    
    if has_expiring_domains:
        send_to_teams(message)
    else:
        print("No domains are expiring within the next 30 days.")

if __name__ == "__main__":
    main()
