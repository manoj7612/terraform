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

**Run terraform plan command to view the test execution and pass variables.tfvar file as an argument**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform plan -var-file=variables.tfvar
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGCustom]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGModular"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

**Run terraform apply and pass variables.tfvar file as an argument**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform apply -var-file=variables.tfvar
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGCustom]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGModular"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.rg: Creating...
azurerm_resource_group.rg: Creation complete after 4s [id=/subscriptions/<REDACTED>/resourceGroups/RGModular]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

**Delete the resource using terraform destroy command and remember to pass the filename variables.tfvar as an argument**

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform destroy -var-file=variables.tfvar
azurerm_resource_group.rg: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGModular]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # azurerm_resource_group.rg will be destroyed
  - resource "azurerm_resource_group" "rg" {
      - id       = "/subscriptions/<REDACTED>/resourceGroups/RGModular" -> null
      - location = "centralindia" -> null
      - name     = "RGModular" -> null
      - tags     = {} -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_resource_group.rg: Destroying... [id=/subscriptions/<REDACTED>/resourceGroups/RGModular]
azurerm_resource_group.rg: Still destroying... [id=/subscriptions/<REDACTED>/resourceGroups/RGModular, 00m10s elapsed]
azurerm_resource_group.rg: Destruction complete after 18s

Destroy complete! Resources: 1 destroyed.
@<REDACTED> ➜ /workspaces/terraform (main) $
```


