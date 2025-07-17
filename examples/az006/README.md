

```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform init
Initializing the backend...
Initializing provider plugins...
Terraform has been successfully initialized!
```


```
@<REDACTED> ➜ /workspaces/terraform (main) $ az vm show --name vm01 --resource-group "RGTest" --query id --output tsv
/subscriptions/<REDACTED>/resourceGroups/RGTest/providers/Microsoft.Compute/virtualMachines/vm01
```


```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform import azurerm_linux_virtual_machine.imported_vm "/subscriptions/<REDACTED>/resourceGroups/RGTest/providers/Microsoft.Compute/virtualMachines/vm01"
azurerm_linux_virtual_machine.imported_vm: Importing from ID "/subscriptions/<REDACTED>/resourceGroups/RGTest/providers/Microsoft.Compute/virtualMachines/vm01"...
azurerm_linux_virtual_machine.imported_vm: Import prepared!
azurerm_linux_virtual_machine.imported_vm: Refreshing state... [id=/subscriptions/<REDACTED>/resourceGroups/RGTest/providers/Microsoft.Compute/virtualMachines/vm01]

Import successful!
```



```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform state list
azurerm_linux_virtual_machine.imported_vm
```


```
@<REDACTED> ➜ /workspaces/terraform (main) $ terraform show -no-color > imported_vm.tf


resource "azurerm_linux_virtual_machine" "imported_vm" {
  admin_password                  = (sensitive value)
  admin_username                  = "azureuser"
  allow_extension_operations      = true
  availability_set_id             = null
  computer_name                   = "vm01"
  dedicated_host_group_id         = null
  dedicated_host_id               = null
  disable_password_authentication = false
  edge_zone                       = null
  encryption_at_host_enabled      = false
  eviction_policy                 = null
  extensions_time_budget          = "PT1H30M"
  id                              = "/subscriptions/<REDACTED>/resourceGroups/RGTest/providers/Microsoft.Compute/virtualMachines/vm01"
  license_type                    = null
  location                        = "centralindia"
  max_bid_price                   = -1
  name                            = "vm01"
  network_interface_ids           = [
    "/subscriptions/<REDACTED>/resourceGroups/RGTest/providers/Microsoft.Network/networkInterfaces/vm01888",
  ]
  patch_mode                      = "ImageDefault"
  platform_fault_domain           = -1
  priority                        = "Regular"
  private_ip_address              = "10.0.0.4"
  private_ip_addresses            = [
    "10.0.0.4",
  ]
  provision_vm_agent              = true
  proximity_placement_group_id    = null
  public_ip_address               = "4.247.128.90"
  public_ip_addresses             = [
    "4.247.128.90",
  ]
  resource_group_name             = "RGTest"
  secure_boot_enabled             = false
  size                            = "Standard_B1s"
  source_image_id                 = null
  tags                            = {}
  user_data                       = null
  virtual_machine_id              = "86c7046c-f941-4ab3-9b6a-b019b30a0f23"
  virtual_machine_scale_set_id    = null
  vtpm_enabled                    = false
  zone                            = null

  additional_capabilities {
    ultra_ssd_enabled = false
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  os_disk {
    caching                   = "ReadWrite"
    disk_encryption_set_id    = null
    disk_size_gb              = 30
    name                      = "vm01_disk1_a94035423a5f4a219a422efaeeee18fe"
    storage_account_type      = "Standard_LRS"
    write_accelerator_enabled = false
  }

  source_image_reference {
    offer     = "ubuntu-24_04-lts"
    publisher = "canonical"
    sku       = "server"
    version   = "latest"
  }

  timeouts {}
}
```



```
@<REDACTED> ➜ /workspaces/terraform (main) $ rm imported_vm.tf
```
