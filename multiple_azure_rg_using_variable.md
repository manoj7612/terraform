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

**Run terraform plan command to get an overview of the resource groups to be created**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan
Acquiring state lock. This may take a few moments...
azurerm_resource_group.rg1: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGStorage]
azurerm_resource_group.rg2: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGNetwork]
azurerm_resource_group.rg3: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGTest]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg1 will be created
  + resource "azurerm_resource_group" "rg1" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGStorage"
    }

  # azurerm_resource_group.rg2 will be created
  + resource "azurerm_resource_group" "rg2" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGNetwork"
    }

  # azurerm_resource_group.rg3 will be created
  + resource "azurerm_resource_group" "rg3" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGTest"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

**Run the command terraform apply to run the terraform script to create 3 resource groups in azure as specified**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply
azurerm_resource_group.rg3: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGTest]
azurerm_resource_group.rg2: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGNetwork]
azurerm_resource_group.rg1: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGStorage]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg1 will be created
  + resource "azurerm_resource_group" "rg1" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGStorage"
    }

  # azurerm_resource_group.rg2 will be created
  + resource "azurerm_resource_group" "rg2" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGNetwork"
    }

  # azurerm_resource_group.rg3 will be created
  + resource "azurerm_resource_group" "rg3" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGTest"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg3: Creating...
azurerm_resource_group.rg1: Creating...
azurerm_resource_group.rg2: Creating...
azurerm_resource_group.rg2: Creation complete after 4s [id=/subscriptions/<REDACTED>/resourceGroups/RGNetwork]
azurerm_resource_group.rg1: Creation complete after 4s [id=/subscriptions/<REDACTED>/resourceGroups/RGStorage]
azurerm_resource_group.rg3: Creation complete after 5s [id=/subscriptions/<REDACTED>/resourceGroups/RGTest]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

**List the resource group in azure to confirm that all the 3 resource groups are created successfully**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ az group list
[
  {
    "id": "/subscriptions/<REDACTED>/resourceGroups/NetworkWatcherRG",
    "location": "centralindia",
    "managedBy": null,
    "name": "NetworkWatcherRG",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/<REDACTED>/resourceGroups/RGStorage",
    "location": "centralindia",
    "managedBy": null,
    "name": "RGStorage",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {},
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/<REDACTED>/resourceGroups/RGNetwork",
    "location": "centralindia",
    "managedBy": null,
    "name": "RGNetwork",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {},
    "type": "Microsoft.Resources/resourceGroups"
  },
  {
    "id": "/subscriptions/<REDACTED>/resourceGroups/RGTest",
    "location": "centralindia",
    "managedBy": null,
    "name": "RGTest",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": {},
    "type": "Microsoft.Resources/resourceGroups"
  }
]
@<REDACTED> ➜ /workspaces/terraform (main) $
```


