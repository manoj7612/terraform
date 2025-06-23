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

**Run the command terraform plan to get an overview of the output of the terraform script**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan
azurerm_resource_group.rg2: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGNetwork]
azurerm_resource_group.rg1: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGStorage]
azurerm_resource_group.rg3: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGTest]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.RGVar01 will be created
  + resource "azurerm_resource_group" "RGVar01" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGVar01"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

**Run the command 'terraform apply' to create the resource group in azure by receiving the resource group name as a parameter from terraform.tfvars file.**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply
azurerm_resource_group.rg3: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGTest]
azurerm_resource_group.rg1: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGStorage]
azurerm_resource_group.rg2: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGNetwork]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.RGVar01 will be created
  + resource "azurerm_resource_group" "RGVar01" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGVar01"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.RGVar01: Creating...
azurerm_resource_group.RGVar01: Creation complete after 3s [id=/subscriptions/<REDACTED>/resourceGroups/RGVar01]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
@<REDACTED> ➜ /workspaces/terraform (main) $
```




