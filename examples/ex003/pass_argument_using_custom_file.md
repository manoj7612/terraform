**Initialize terraform using init command**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Using previously-installed hashicorp/azurerm v3.0.2

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

**Run terraform plan command and pass the filename as parameter using: -var-file="test.tfvars"**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan -var-file="test.tfvars"
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGParams]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGCustom"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

**Run the terraform apply command and pass the filename as a command line parameter: -var-file="test.tfvars"**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply -var-file="test.tfvars"
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGParams]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGCustom"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 4s [id=/subscriptions/<REDACTED>/resourceGroups/RGCustom]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

**Run 'az group show' command to verify that the resource group with the name 'RGCustom' is created**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name RGCustom
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/RGCustom",
  "location": "centralindia",
  "managedBy": null,
  "name": "RGCustom",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": {},
  "type": "Microsoft.Resources/resourceGroups"
}
@<REDACTED> ➜ /workspaces/terraform (main) $
```

