**Run terraform show command to check the output from the state file, if any.**

```
@<REDACTED> ➜ /workspaces/terraform/aztest (main) $ terraform show
The state file is empty. No resources are represented.
```

**Run terraform init command to initialize the terraform working directory**

```
@<REDACTED> ➜ /workspaces/terraform/aztest (main) $ terraform init
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

**Run terraform plan to create and view the execution plan before making any changes to your infrastructure**

```
@<REDACTED> ➜ /workspaces/terraform/aztest (main) $ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_network_interface.vNet01 will be created
  + resource "azurerm_network_interface" "vNet01" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "vnic01"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "RGTerraform"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "ipconfig01"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_network_interface_security_group_association.vnic_nsg01 will be created
  + resource "azurerm_network_interface_security_group_association" "vnic_nsg01" {
      + id                        = (known after apply)
      + network_interface_id      = (known after apply)
      + network_security_group_id = (known after apply)
    }

  # azurerm_network_security_group.nsg01 will be created
  + resource "azurerm_network_security_group" "nsg01" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "nsg01"
      + resource_group_name = "RGTerraform"
      + security_rule       = (known after apply)
    }

  # azurerm_network_security_rule.nsg_rule01 will be created
  + resource "azurerm_network_security_rule" "nsg_rule01" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "22"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "nsg-rule-01"
      + network_security_group_name = "nsg01"
      + priority                    = 100
      + protocol                    = "Tcp"
      + resource_group_name         = "RGTerraform"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # azurerm_public_ip.pip01 will be created
  + resource "azurerm_public_ip" "pip01" {
      + allocation_method       = "Static"
      + domain_name_label       = "pip01-label"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "centralindia"
      + name                    = "pip01"
      + resource_group_name     = "RGTerraform"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
    }

  # azurerm_resource_group.RGRemoteBackend will be created
  + resource "azurerm_resource_group" "RGRemoteBackend" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGTerraform"
    }

  # azurerm_subnet.subnet01 will be created
  + resource "azurerm_subnet" "subnet01" {
      + address_prefixes = [
          + "10.1.0.0/16",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id              = (known after apply)
      + name            = "subnet01"
      + resource_group_name  = "RGTerraform"
      + virtual_network_name = "vnet01"
    }

  # azurerm_virtual_machine.vm01 will be created
  + resource "azurerm_virtual_machine" "vm01" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = false
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "centralindia"
      + name                             = "vm01"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "RGTerraform"
      + vm_size                          = "Standard_B1s"

      + identity (known after apply)

      + os_profile {
          # sensitive output hidden
        }

      + os_profile_linux_config {
          + disable_password_authentication = true

          + ssh_keys {
              + key_data = "ssh-rsa AAAAB3...<REDACTED>...codespace@codespaces-7e611f"
              + path     = "/home/codespace/.ssh/authorized_keys"
            }
        }

      + storage_data_disk (known after apply)

      + storage_image_reference {
          + offer     = "0001-com-ubuntu-server-jammy"
          + publisher = "Canonical"
          + sku       = "22_04-lts"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = 250
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Standard_LRS"
          + name                      = "disk01"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # azurerm_virtual_network.vNet01 will be created
  + resource "azurerm_virtual_network" "vNet01" {
      + address_space = [
          + "10.0.0.0/8",
        ]
      + dns_servers = [
          + "8.8.8.8",
          + "8.8.4.4",
        ]
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "vnet01"
      + resource_group_name = "RGTerraform"
      + subnet              = (known after apply)
    }

Plan: 9 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

```

**Run terraform apply to create the resources in azure**

```
@<REDACTED> ➜ /workspaces/terraform/aztest (main) $ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_network_interface.vNet01 will be created
  + resource "azurerm_network_interface" "vNet01" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "centralindia"
      + mac_address                   = (known after apply)
      + name                          = "vnic01"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "RGTerraform"
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "ipconfig01"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_network_interface_security_group_association.vnic_nsg01 will be created
  + resource "azurerm_network_interface_security_group_association" "vnic_nsg01" {
      + id                        = (known after apply)
      + network_interface_id      = (known after apply)
      + network_security_group_id = (known after apply)
    }

  # azurerm_network_security_group.nsg01 will be created
  + resource "azurerm_network_security_group" "nsg01" {
      + id                  = (known after apply)
      + location            = "centralindia"
      + name                = "nsg01"
      + resource_group_name = "RGTerraform"
      + security_rule       = (known after apply)
    }

  # azurerm_network_security_rule.nsg_rule01 will be created
  + resource "azurerm_network_security_rule" "nsg_rule01" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "22"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "nsg-rule-01"
      + network_security_group_name = "nsg01"
      + priority                    = 100
      + protocol                    = "Tcp"
      + resource_group_name         = "RGTerraform"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # azurerm_public_ip.pip01 will be created
  + resource "azurerm_public_ip" "pip01" {
      + allocation_method       = "Static"
      + domain_name_label       = "pip01-label"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "centralindia"
      + name                    = "pip01"
      + resource_group_name     = "RGTerraform"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
    }

  # azurerm_resource_group.RGRemoteBackend will be created
  + resource "azurerm_resource_group" "RGRemoteBackend" {
      + id       = (known after apply)
      + location = "centralindia"
      + name     = "RGTerraform"
    }

  # azurerm_subnet.subnet01 will be created
  + resource "azurerm_subnet" "subnet01" {
      + address_prefixes                               = [
          + "10.1.0.0/16",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "subnet01"
      + resource_group_name                            = "RGTerraform"
      + virtual_network_name                           = "vnet01"
    }

  # azurerm_virtual_machine.vm01 will be created
  + resource "azurerm_virtual_machine" "vm01" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = false
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "centralindia"
      + name                             = "vm01"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "RGTerraform"
      + vm_size                          = "Standard_B1s"

      + identity (known after apply)

      + os_profile {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      + os_profile_linux_config {
          + disable_password_authentication = true

          + ssh_keys {
              + key_data = "ssh-rsa AAAAB3N...<redacted>...1cR8="
              + path     = "/home/codespace/.ssh/authorized_keys"
            }
        }

      + storage_data_disk (known after apply)

      + storage_image_reference {
          + offer     = "0001-com-ubuntu-server-jammy"
          + publisher = "Canonical"
          + sku       = "22_04-lts"
          + version   = "latest"
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = 250
          + managed_disk_type         = "Standard_LRS"
          + name                      = "disk01"
          + write_accelerator_enabled = false
        }
    }

  # azurerm_virtual_network.vNet01 will be created
  + resource "azurerm_virtual_network" "vNet01" {
      + address_space       = [
          + "10.0.0.0/8",
        ]
      + dns_servers         = [
          + "8.8.8.8",
          + "8.8.4.4",
        ]
      + location            = "centralindia"
      + name                = "vnet01"
      + resource_group_name = "RGTerraform"
    }

Plan: 9 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.RGRemoteBackend: Creating...
azurerm_resource_group.RGRemoteBackend: Creation complete after 4s
azurerm_virtual_network.vNet01: Creating...
azurerm_network_security_group.nsg01: Creating...
azurerm_public_ip.pip01: Creating...
azurerm_network_security_group.nsg01: Creation complete after 3s
azurerm_network_security_rule.nsg_rule01: Creating...
azurerm_virtual_network.vNet01: Creation complete after 5s
azurerm_subnet.subnet01: Creating...
azurerm_network_security_rule.nsg_rule01: Creation complete after 2s
azurerm_public_ip.pip01: Creation complete after 5s
azurerm_subnet.subnet01: Creation complete after 5s
azurerm_network_interface.vNet01: Creating...
azurerm_network_interface.vNet01: Creation complete after 4s
azurerm_network_interface_security_group_association.vnic_nsg01: Creating...
azurerm_virtual_machine.vm01: Creating...
azurerm_network_interface_security_group_association.vnic_nsg01: Creation complete after 4s
azurerm_virtual_machine.vm01: Still creating... [00m10s elapsed]
azurerm_virtual_machine.vm01: Still creating... [00m20s elapsed]
azurerm_virtual_machine.vm01: Still creating... [00m30s elapsed]
azurerm_virtual_machine.vm01: Still creating... [00m40s elapsed]
azurerm_virtual_machine.vm01: Creation complete after 49s

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.
```

**Copy id_rsa.pub to the newly created virtual machine**

```
@<REDACTED> ➜ /workspaces/terraform/aztest (main) $ ssh-copy-id -i /home/codespace/.ssh/id_rsa.pub codespace@4.213.160.57
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/codespace/.ssh/id_rsa.pub"
The authenticity of host '4.213.160.57 (4.213.160.57)' can't be established.
ECDSA key fingerprint is SHA256:GNnMkoMFDBZL7hZejqc8bXkq4LZ+I7HM99CZzHi3nvU.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed

/usr/bin/ssh-copy-id: WARNING: All keys were skipped because they already exist on the remote system.
                (if you think this is a mistake, you may want to use -f option)
```

**SSH to the newly created virtual machine using 'codespace' as the username and the public ip of the new virtual machine**

```
@<REDACTED> ➜ /workspaces/terraform/aztest (main) $ ssh codespace@4.213.160.57
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sun Jun 29 06:25:47 UTC 2025

  System load:  0.0                Processes:             111
  Usage of /:   0.6% of 242.11GB   Users logged in:       0
  Memory usage: 28%                IPv4 address for eth0: 10.1.0.4
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status

The list of available updates is more than a week old.
To check for new updates run: sudo apt update
New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

**Run the command df -h to view the disk space utilization on this new virtual machine**

```
codespace@myvm:~$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       243G  1.6G  241G   1% /
tmpfs           450M     0  450M   0% /dev/shm
tmpfs           180M  1.1M  179M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/sdb15      105M  6.1M   99M   6% /boot/efi
/dev/sda1       3.9G   28K  3.7G   1% /mnt
tmpfs            90M  4.0K   90M   1% /run/user/1000
codespace@myvm:~$

```

**Run terraform destroy command to destroy all these resources**

```
@<REDACTED> ➜ /workspaces/terraform/aztest (main) $ terraform destroy
```


