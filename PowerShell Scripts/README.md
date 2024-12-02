# PowerShell Scripts for Microsoft Teams Management

Welcome to the **PowerShell Scripts for Microsoft Teams Management** repository! This collection of scripts is designed to help IT administrators efficiently manage Microsoft Teams environments using PowerShell.  For more how-to guides, please check out https://www.daveherrell.com/category/ms365/ms-teams/

## Features

- **Team Management**: Automate the creation and configuration of Microsoft Teams.
- **User Administration**: Add or remove members and manage team roles.
- **Channel Management**: Create and organize channels within teams.
- **Reporting**: Generate reports on Teams and user activity.
- **Customization**: Scripts are modular and can be tailored to your specific needs.

## Prerequisites

Before running these scripts, ensure you have the following:

1. **PowerShell Version**:
   - Use the latest version of PowerShell. [Download PowerShell](https://learn.microsoft.com/en-us/powershell/).

2. **Microsoft Teams PowerShell Module**:
   - Install the module with the following command:
     ```powershell
     Install-Module -Name PowerShellGet -Force -AllowClobber
     Install-Module -Name MicrosoftTeams -Force
     ```

3. **Microsoft Graph API Permissions**:
   - Ensure the proper permissions are set in your Azure AD environment (e.g., `TeamSettings.ReadWrite.All`, `User.ReadWrite.All`).

4. **Authentication**:
   - Configure your scripts for user or application-based authentication.

## Getting Started

1. Clone the repository:
   ```powershell
   git clone https://github.com/it-dherrell/teams.git
   cd teams/PowerShell%20Scripts
   ```

2. Review and update script parameters:
   - Open the script file and update variables or parameters as needed.

3. Run the script:
   ```powershell
   .\script_name.ps1
   ```

## Repository Structure

- **`Create-Team.ps1`**: Automates the creation of new Microsoft Teams.
- **`Manage-Members.ps1`**: Manages team members by adding or removing users.
- **`Channel-Management.ps1`**: Handles channel creation and organization.
- **`Teams-Report.ps1`**: Generates activity and usage reports for Microsoft Teams.
- **`README.md`**: Documentation and usage instructions.

## Contributing

I welcome contributions! If you have improvements or new scripts to add, feel free to fork this repository and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](../LICENSE) file for details.

## Support

If you have any questions or encounter issues, please create an issue in this repository or contact me direct!

---

Happy scripting!
