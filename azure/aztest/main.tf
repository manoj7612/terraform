# Created by: Manoj Agarwal
# Description: This Terraform script sets up a remote backend in Azure with a resource group, virtual network, subnet, managed disk, public IP, network interface, network security group, and a virtual machine.
# Created on: 2025-06-29
# Version: 1.0.0

# Create a Resource Group
resource "azurerm_resource_group" "RGRemoteBackend" {
  name     = var.group_name
  location = var.location
}

# Create a virtual network
resource "azurerm_virtual_network" "vNet01" {
  name                = var.vnet_name
  location            = azurerm_resource_group.RGRemoteBackend.location
  resource_group_name = azurerm_resource_group.RGRemoteBackend.name
  address_space       = var.vnet_address_space
  dns_servers         = var.vnet_dns_servers
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.RGRemoteBackend.name
  virtual_network_name = azurerm_virtual_network.vNet01.name
  address_prefixes     = var.subnet_address_prefix
}

# Create a managed disk
/*
resource "azurerm_managed_disk" "disk01" {
  name                 = var.disk_name
  resource_group_name  = azurerm_resource_group.RGRemoteBackend.name
  location             = azurerm_resource_group.RGRemoteBackend.location
  storage_account_type = var.disk_sku
  create_option        = var.disk_create_option
  disk_size_gb         = var.disk_size_gb
}
*/

# Create a public IP address
resource "azurerm_public_ip" "pip01" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.RGRemoteBackend.location
  resource_group_name = azurerm_resource_group.RGRemoteBackend.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  domain_name_label   = var.public_ip_domain_name_label
}

# Create a network interface
resource "azurerm_network_interface" "vNet01" {
  name                = var.vnic_name
  location            = azurerm_resource_group.RGRemoteBackend.location
  resource_group_name = azurerm_resource_group.RGRemoteBackend.name

  ip_configuration {
    name                          = var.ip_config_name
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip01.id
  }
}

# Create a Network Security Group
resource "azurerm_network_security_group" "nsg01" {
  name                = var.nsg_name
  location            = azurerm_resource_group.RGRemoteBackend.location
  resource_group_name = azurerm_resource_group.RGRemoteBackend.name
}

# Create a Network Security Rule
resource "azurerm_network_security_rule" "nsg_rule01" {
  name                        = var.nsg_rule_name
  priority                    = var.nsg_rule_priority
  direction                   = var.nsg_rule_direction
  access                      = var.nsg_rule_access
  protocol                    = var.nsg_rule_protocol
  source_port_range           = var.nsg_rule_source_port_range
  destination_port_range      = var.nsg_rule_destination_port_range
  source_address_prefix       = var.nsg_rule_source_address_prefix
  destination_address_prefix  = var.nsg_rule_destination_address_prefix
  resource_group_name = azurerm_resource_group.RGRemoteBackend.name
  network_security_group_name = azurerm_network_security_group.nsg01.name
}

# Associate the Network Security Group with the Network Interface
resource "azurerm_network_interface_security_group_association" "vnic_nsg01" {
  network_interface_id      = azurerm_network_interface.vNet01.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
}

# Create a virtual machine
resource "azurerm_virtual_machine" "vm01" { 
  name                  = var.vm_name
  location              = azurerm_resource_group.RGRemoteBackend.location
  resource_group_name   = azurerm_resource_group.RGRemoteBackend.name
  network_interface_ids = [azurerm_network_interface.vNet01.id]
  vm_size               = var.vm_size

 storage_image_reference {
    publisher = var.vm_storage_image_publisher
    offer     = var.vm_storage_image_offer
    sku       = var.vm_storage_image_sku
    version   = var.vm_storage_image_version
  }

 storage_os_disk {
    name              = var.disk_name
    caching           = var.disk_caching
    create_option     = "FromImage" 
    disk_size_gb      = var.disk_size_gb    
    managed_disk_type = var.disk_sku
  }

 os_profile {
  computer_name  = "myvm"
  admin_username = "codespace"
 }

 os_profile_linux_config {
  disable_password_authentication = true

  ssh_keys {
    path     = "/home/codespace/.ssh/authorized_keys"
    key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj6ot/EMPDF7q0IxZvR4HAt3jK/lSfLJseT7iEyTsRRRfbLvp1Pwpm3hYrlwevPv5kv9nU33V0SiUczBzANwZB9LEeerb9qFvaTIRsImPiEeNtB7eppVFFpfGM2Fo5MzH/RiT2vmT+ceAUJU7W3UdB5EF2tbRlnreXuO9CvQJOXyN9CAwywXmdkTylXaxyvHT+t7vZ18P7JjIO20L0gpRBLwE8N6a4tZ6/6iEWZp/NQbQVpPQz3a2Ggd7NKM9oWDt3WVRu7UZzQuaiklXPttJhmBFOD7ArFKy8rFax6ECnZozH9tZ46Ble74PeXPOQreJd/DhaIixdtfINw3ZMaBunM1DYtWO/Uv5mVt/WKtQHFfPtRzviZAHLtxLFIteWL8LKQGT+IEER8ucvSScFnAhbzg7qIyIUptwviymiqrqn43E9OvPFBSRaKYLV6ihtmSd9k3siHMV3Lax456ZEYG2qUFE9B5STjXicxK0IO5pB8BSBn7A5jULaPSVAoVw1cR8= codespace@codespaces-7e611f"
  }
 }
}
