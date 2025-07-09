**Terraform Workspace**

```
Usage: terraform [global options] workspace

  new, list, show, select and delete Terraform workspaces.

Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace
```

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace new dev
Created and switched to workspace "dev"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace show
dev

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
* dev

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace select default
Switched to workspace "default".

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace show
default

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace select dev
Switched to workspace "dev".

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace show
dev

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace delete dev
Workspace "dev" is your active workspace.

You cannot delete the currently active workspace. Please switch
to another workspace and try again.

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace select default
Switched to workspace "default".

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace show
default

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace delete dev
Deleted workspace "dev"!

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
* default
```

**Create a main.tf file that creates a new Azure resource group in Central India location using dev workspace and name it RGDev.
Now, create another Azure resource group in Central India location using prod workspace and name it RGProd.**


```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
* default

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace new dev
Created and switched to workspace "dev"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
* dev

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace new prod
Created and switched to workspace "prod"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
  dev
* prod

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace select dev
Switched to workspace "dev".

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace show
dev

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

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan -var="group_name=RGDev" -var="location=CentralIndia"

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGDev"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply -var="group_name=RGDev" -var="location=CentralIndia"

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGDev"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions in workspace "dev"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 3s [id=/subscriptions/<REDACTED>/resourceGroups/RGDev]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace show
dev
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name RGDev
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/RGDev",
  "location": "centralindia",
  "managedBy": null,
  "name": "RGDev",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": {},
  "type": "Microsoft.Resources/resourceGroups"
}
@<REDACTED> ➜ /workspaces/terraform (main) $ 

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
* dev
  prod

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace select prod
Switched to workspace "prod".
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
  dev
* prod

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
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan -var="group_name=RGProd" -var="location=CentralIndia"

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGProd"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply -var="group_name=RGProd" -var="location=CentralIndia"

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGProd"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions in workspace "prod"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 4s [id=/subscriptions/<REDACTED>/resourceGroups/RGProd]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name RGProd
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/RGProd",
  "location": "centralindia",
  "managedBy": null,
  "name": "RGProd",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": {},
  "type": "Microsoft.Resources/resourceGroups"
}
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name RGDev
{
  "id": "/subscriptions/<REDACTED>/resourceGroups/RGDev",
  "location": "centralindia",
  "managedBy": null,
  "name": "RGDev",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": {},
  "type": "Microsoft.Resources/resourceGroups"
}
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
  dev
* prod

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform destroy
var.group_name
  The name of the resource group

  Enter a value: RGProd

var.location
  The Azure region where the resource group will be created

  Enter a value: CentralIndia

azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGProd]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be destroyed
  - resource "azurerm_resource_group" "rg" {
      - id       = "/subscriptions/<REDACTED>/resourceGroups/RGProd" -> null
      - location = "centralindia" -> null
      - name     = "RGProd" -> null
      - tags     = {} -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources in workspace "prod"?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_resource_group.rg: Destroying... [id=/subscriptions/<REDACTED>/resourceGroups/RGProd]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/<REDACTED>/resourceGroups/RGProd, 00m10s elapsed]
azurerm_resource_group.rg: Destruction complete after 16s

Destroy complete! Resources: 1 destroyed.
@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name RGProd
(ResourceGroupNotFound) Resource group 'RGProd' could not be found.
Code: ResourceGroupNotFound
Message: Resource group 'RGProd' could not be found.
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
  dev
* prod

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace select dev
Switched to workspace "dev".
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform destroy -var="group_name=RGProd" -var="location=CentralIndia"
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGDev]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be destroyed
  - resource "azurerm_resource_group" "rg" {
      - id       = "/subscriptions/<REDACTED>/resourceGroups/RGDev" -> null
      - location = "centralindia" -> null
      - name     = "RGDev" -> null
      - tags     = {} -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources in workspace "dev"?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_resource_group.rg: Destroying... [id=/subscriptions/<REDACTED>/resourceGroups/RGDev]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/<REDACTED>/resourceGroups/RGDev, 00m10s elapsed]
azurerm_resource_group.rg: Destruction complete after 16s

Destroy complete! Resources: 1 destroyed.

@<REDACTED> ➜ /workspaces/terraform (main) $ az group show --name RGDev
(ResourceGroupNotFound) Resource group 'RGDev' could not be found.
Code: ResourceGroupNotFound
Message: Resource group 'RGDev' could not be found.
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
  default
* dev
  prod

@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace delete prod
Deleted workspace "prod"!
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace select default
Switched to workspace "default".
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace delete dev
Deleted workspace "dev"!
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform workspace list
* default

@<REDACTED> ➜ /workspaces/terraform (main) $ 

```




