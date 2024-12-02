# Python Scripts for Microsoft Teams Management

Welcome to the **Python Scripts for Microsoft Teams Management** repository! This collection of scripts is designed to help IT administrators streamline and automate the management of Microsoft Teams using Python and the Microsoft Graph API.  For more information check out my how-to guides at https://www.daveherrell.com/category/ms365/ms-teams/

## Features

- **Automated Team Creation**: Create teams programmatically to streamline setup processes.
- **User Management**: Add, remove, or update team members.
- **Channel Management**: Create and manage channels within teams.
- **Reporting**: Generate reports on team and user activity.
- **Customization**: Scripts are modular and customizable to suit various business needs.

## Prerequisites

Before using these scripts, ensure you have the following:

1. **Python Installed**: [Download Python](https://www.python.org/downloads/).
2. **Microsoft Graph API Access**:
   - Register an application in Azure AD.
   - Assign the necessary permissions (e.g., `Group.ReadWrite.All`, `User.Read.All`).
3. **Dependencies Installed**:
   - Install required Python libraries: `pip install -r requirements.txt`.
4. **Authentication**:
   - Set up authentication for the Microsoft Graph API (e.g., client credentials or delegated permissions).

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/it-dherrell/teams.git
   cd teams/Python%20Scripts
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Configure your environment:
   - Update the `config.json` file with your Azure AD app credentials.

4. Run a script:
   ```bash
   python script_name.py
   ```

## Scripts

- **python-domain-expiration-alert-to-teams.py**: Domain Expiration alerts into your Microsoft Teams channel.
- **python-ssl-expiration-alert-teams.py**: SSL Expiration Alerts to a designated Teams channel.


## Contributing

Contributions are welcome! If you have ideas or improvements, feel free to fork the repository and submit a pull request.


## Support

For any questions or issues, please create an issue in this repository or contact me direct!

---

Happy scripting!

