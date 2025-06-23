**Pass group_name as an argument through command line.**

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

**Run the terraform plan command to get an overview of the working of the terraform script. Remember to pass the parameter as: -var="group_name=RGParams"**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan -var="group_name=RGParams"
azurerm_resource_group.RGVar01: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGVar01]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGParams"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
╷
│ Warning: Value for undeclared variable
│ 
│ The root module does not declare a variable named "location" but a value was found in file "terraform.tfvars". If you meant to use this value, add a "variable" block to the
│ configuration.
│ 
│ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all configurations in your organization. To reduce the verbosity of
│ these warnings, use the -compact-warnings option.
╵

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

**Run the terraform script using the command 'terraform apply' and pass the command line argument: -var="group_name=RGParams"**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply -var="group_name=RGParams"
azurerm_resource_group.RGVar01: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGVar01]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGParams"
    }

Plan: 1 to add, 0 to change, 0 to destroy.
╷
│ Warning: Value for undeclared variable
│ 
│ The root module does not declare a variable named "location" but a value was found in file "terraform.tfvars". If you meant to use this value, add a "variable" block to the
│ configuration.
│ 
│ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all configurations in your organization. To reduce the verbosity of
│ these warnings, use the -compact-warnings option.
╵

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 4s [id=/subscriptions/<REDACTED>/resourceGroups/RGParams]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

**Show the resource group named 'RGParams' in Azure using 'az group show' command**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name RGParams
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/RGParams",
  "location": "centralindia",
  "managedBy": null,
  "name": "RGParams",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": {},
  "type": "Microsoft.Resources/resourceGroups"
}
@<REDACTED> ➜ /workspaces/terraform (main) $
```

