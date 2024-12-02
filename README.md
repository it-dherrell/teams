# Microsoft Teams Management Scripts

Welcome to the **Microsoft Teams Management Scripts** repository! This repository contains collections of Python and PowerShell scripts designed to help IT administrators manage Microsoft Teams environments more efficiently.  For more information and step-by-step guides check out my write ups here: https://www.daveherrell.com/category/ms365/ms-teams/

## Features

- **Team Management**: Automate the creation, configuration, and maintenance of Teams.
- **User Administration**: Manage team memberships and roles.
- **Channel Management**: Create, organize, and customize channels.
- **Reporting**: Generate reports on team activity and usage.
- **Cross-Platform Support**: Choose between Python and PowerShell scripts based on your environment and needs.

## Repository Structure

- **Python Scripts**: Located in the [`Python Scripts`](./Python%20Scripts) directory, these scripts leverage the Microsoft Graph API for advanced automation.
- **PowerShell Scripts**: Found in the [`PowerShell Scripts`](./PowerShell%20Scripts) directory, these scripts utilize the Microsoft Teams PowerShell module for streamlined management.
- **README Files**: Documentation for both script collections is included in their respective directories.

## Getting Started

### Prerequisites

- **Python Scripts**:
  1. Install Python. [Download Python](https://www.python.org/downloads/).
  2. Set up Microsoft Graph API access and authentication.
  3. Install dependencies using `pip install -r requirements.txt`.

- **PowerShell Scripts**:
  1. Install the latest version of PowerShell. [Download PowerShell](https://learn.microsoft.com/en-us/powershell/).
  2. Install the Microsoft Teams PowerShell module using:
     ```powershell
     Install-Module -Name MicrosoftTeams -Force
     ```
  3. Configure your environment for authentication.

### Usage

1. Navigate to the desired script collection:
   - Python scripts: `cd Python Scripts`
   - PowerShell scripts: `cd PowerShell Scripts`

2. Review and update the configuration for your use case.

3. Execute the script:
   - Python: `python script_name.py`
   - PowerShell: `.\script_name.ps1`

## Contributing

Contributions are welcome! Feel free to fork this repository, make your changes, and submit a pull request.


## Support

If you encounter any issues or have questions, please create an issue in this repository or contact me direct.
