variable "group_name" {
  description = "The name of the resource group to create."
  type        = string    
}

variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string   
}

variable "vnet_name" {
  description = "The name of the virtual network to create."
  type        = string
}       

variable "subnet_name" {
  description = "The name of the subnet to create."
  type        = string          
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
}   

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet."
  type        = list(string)
}   

variable "vnet_dns_servers" {
  description = "The DNS servers for the virtual network."
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "vnic_name" {
  description = "The name of the virtual network interface card (vNIC) to create."
  type        = string  
}

variable "ip_config_name" {
  description = "The name of the IP configuration for the vNIC."
  type        = string  
}

variable "disk_name" {
  description = "The name of the managed disk to create."
  type        = string
}

variable "disk_size_gb" {
  description = "The size of the managed disk in GB."
  type        = number
  default     = 128 
}
variable "disk_sku" {
  description = "The SKU of the managed disk."
  type        = string
  default     = "Standard_LRS"
}   

variable "disk_create_option" {
  description = "The create option for the managed disk."
  type        = string
  default     = "Empty"
}

variable "disk_caching" {
  description = "The caching option for the managed disk."
  type        = string
  default     = "ReadWrite"
}

variable "public_ip_name" {
  description = "The name of the public IP address to create."
  type        = string  
}

variable "public_ip_sku" {
  description = "The SKU of the public IP address."
  type        = string
  default     = "Standard"
}

variable "public_ip_allocation_method" {
  description = "The allocation method for the public IP address."
  type        = string
  default     = "Dynamic"
}

variable "public_ip_domain_name_label" {
  description = "The domain name label for the public IP address."
  type        = string
  default     = "pip01-label"
}

variable "nsg_name" {
  description = "The name of the network security group (NSG) to create."
  type        = string  
}

variable "nsg_rule_name" {
  description = "The name of the NSG rule to create."
  type        = string  
}   

variable "nsg_rule_priority" {
  description = "The priority of the NSG rule."
  type        = number
  default     = 100
}       

variable "nsg_rule_direction" {
  description = "The direction of the NSG rule (Inbound/Outbound)."
  type        = string
  default     = "Inbound"
}

variable "nsg_rule_access" {
  description = "The access type for the NSG rule (Allow/Deny)."
  type        = string
  default     = "Allow" 
}

variable "nsg_rule_protocol" {
  description = "The protocol for the NSG rule (Tcp/Udp/Asterisk)."
  type        = string
  default     = "Tcp"
}

variable "nsg_rule_source_address_prefix" {
  description = "The source address prefix for the NSG rule."
  type        = string
  default     = "*" 
}

variable "nsg_rule_source_port_range" {
  description = "The source port range for the NSG rule."
  type        = string
  default     = "*" 
}

variable "nsg_rule_destination_address_prefix" {
  description = "The destination address prefix for the NSG rule."
  type        = string
  default     = "*"     
}

variable "nsg_rule_destination_port_range" {
  description = "The destination port range for the NSG rule."
  type        = string
  default     = "22"    
}

variable "nsg_rule_description" {
  description = "A description for the NSG rule."
  type        = string
  default     = "Allow SSH access"
}

variable "nsg_rule_enabled" {
  description = "Whether the NSG rule is enabled."
  type        = bool
  default     = true    
}

variable "vm_name" {
  description = "The name of the virtual machine to create."
  type        = string  
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
  default     = "Standard_B1s"  
}

variable "vm_storage_image_publisher" {
  description = "The publisher of the virtual machine image."
  type        = string
  default     = "Canonical"
}

variable "vm_storage_image_offer" {
  description = "The offer of the virtual machine image."
  type        = string
  default     = "0001-com-ubuntu-server-jammy"      
}

variable "vm_storage_image_sku" {
  description = "The SKU of the virtual machine image."
  type        = string
  default     = "22_04-lts" 
}

variable "vm_storage_image_version" {
  description = "The version of the virtual machine image."
  type        = string
  default     = "latest"
}

variable "vm_storage_image_id" {
  description = "The ID of the virtual machine image."
  type        = string
  default     = "" # Optional, can be used to specify a custom image ID
}
