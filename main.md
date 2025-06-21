**Creating first Terraform configuration file**

**To initialize, type the following command: 'terraform init'**


```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform init
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 3.0.2"...
- Installing hashicorp/azurerm v3.0.2...
- Installed hashicorp/azurerm v3.0.2 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

**Before actually running the command, to check what the command is supposed to do, run 'terraform plan'**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "maTFRG"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
@<REDACTED> ➜ /workspaces/terraform (main) $
```

**Once you are sure of the resources that will be created as shown in the plan output, run the command 'terraform apply' to create these resources.**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "maTFRG"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 3s [id=/subscriptions/<REDACTED>/resourceGroups/maTFRG]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
@<REDACTED> ➜ /workspaces/terraform (main) $
```

**If you wish to delete the resources created using the command above, use the command 'terraform destroy' and it will remove those resources from Azure**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform destroy
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/maTFRG]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be destroyed
  - resource "azurerm_resource_group" "rg" {
      - id       = "/subscriptions/<REDACTED>/resourceGroups/maTFRG" -> null
      - location = "centralindia" -> null
      - name     = "maTFRG" -> null
      - tags     = {} -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_resource_group.rg: Destroying... [id=/subscriptions/<REDACTED>/resourceGroups/maTFRG]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/<REDACTED>/resourceGroups/maTFRG, 00m10s elapsed]
azurerm_resource_group.rg: Destruction complete after 18s

Destroy complete! Resources: 1 destroyed.
@<REDACTED> ➜ /workspaces/terraform (main) $
```




