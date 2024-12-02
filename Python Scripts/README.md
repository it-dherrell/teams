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

## Repository Structure

- **`create_team.py`**: Script to create new Microsoft Teams.
- **`manage_users.py`**: Script for adding or removing users from a team.
- **`channel_manager.py`**: Script to create and manage channels within teams.
- **`reporting.py`**: Script to generate reports on Teams activity.
- **`requirements.txt`**: List of dependencies required to run the scripts.
- **`config.json`**: Configuration file for authentication details (not included, create your own).

## Contributing

Contributions are welcome! If you have ideas or improvements, feel free to fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](../LICENSE) file for details.

## Support

For any questions or issues, please create an issue in this repository or contact the repository owner.

---

Happy scripting!

