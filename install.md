**Install Terraform in CentOS/RHEL and create a Codespaces GitHub environment:**

**CentOS/RHEL:**

Install yum-config-manager to manage your repositories.

`$ sudo yum install -y yum-utils`

Use yum-config-manager to add the official HashiCorp Linux repository.

`$ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo`

Install Terraform from the new repository.

`$ sudo yum -y install terraform`


**Using Codespaces GitHub:**

1. Goto your repository in GitHub or a create a new repository.
2. Click on Code downarrow and then Codespaces tab.
3. Click on + button to create a new codespace on the main branch.
4. Once it is ready, click on the search button at the top and type this command:
   
   `> Add dev container configuration files`
   
6. Modify your active configuration
7. Search for `terraform` and check the arrow next to `Terraform, tflint, and TFGrunt devcontainers`.
8. Search for `aws` and check the arrow next to `AWS CLI devcontainers`.
9. Search for `azure` and check the arrow next to `Azure CLI devcontainers`.
   The following file gets created: `devcontainer.json`

```json
{
	"image": "mcr.microsoft.com/devcontainers/universal:2",
	"features": {
		"ghcr.io/devcontainers/features/aws-cli:1": {},
		"ghcr.io/devcontainers/features/terraform:1": {},
		"ghcr.io/devcontainers/features/azure-cli:1": {}
	}
}
```

11. Once it is done, type the following command in the search button:
    
   `> Codespaces: Rebuild Container`
   
   From the popup, confirm by clicking on the button, `Rebuild`.
   
11. Once it is done, from the terminal shown on the screen, type the following command to verify terraform installation:
    
```bash
a. Verify Terraform:
@manoj7612 ➜ /workspaces/terraform (main) $ terraform --version
Terraform v1.12.2
on linux_amd64

b. Verify AWS CLI:
@manoj7612 ➜ /workspaces/terraform (main) $ aws --version
aws-cli/2.27.37 Python/3.13.4 Linux/6.8.0-1027-azure exe/x86_64.ubuntu.20

c. Verify Azure CLI:
@manoj7612 ➜ /workspaces/terraform (main) $ az --version
azure-cli                         2.72.0 *

core                              2.72.0 *
telemetry                          1.1.0

Dependencies:
msal                              1.32.3
azure-mgmt-resource               23.1.1

Python location '/opt/az/bin/python3'
Config directory '/home/codespace/.azure'
Extensions directory '/home/codespace/.azure/cliextensions'

Python (Linux) 3.12.8 (main, Apr 28 2025, 09:24:09) [GCC 9.4.0]

Legal docs and information: aka.ms/AzureCliLegal


You have 2 update(s) available. Consider updating your CLI installation with 'az upgrade'
@manoj7612 ➜ /workspaces/terraform (main) $ 
```

The terraform environment is now ready to use.
