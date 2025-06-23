# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "group_name1" {
  description = "The name of the resource group"
  type        = string
  default     = "RGStorage" # Default value for the resource group name
  validation {
    condition     = length(var.group_name1) > 0
    error_message = "The resource group name must not be empty."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.group_name1))
    error_message = "The resource group name can only contain alphanumeric characters, underscores, and hyphens."
  }
  
}

variable "group_name2" {
  description = "The name of the second resource group"
  type        = string
  default     = "RGNetwork" # Default value for the second resource group name
  validation {
    condition     = length(var.group_name2) > 0
    error_message = "The second resource group name must not be empty."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.group_name2))
    error_message = "The second resource group name can only contain alphanumeric characters, underscores, and hyphens."
  }
  
}

variable "group_name3" {
  description = "The name of the resource group"
  type        = string
  default     = "RGTest" # Default value for the resource group name
  validation {
    condition     = length(var.group_name3) > 0
    error_message = "The resource group name must not be empty."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.group_name3))
    error_message = "The resource group name can only contain alphanumeric characters, underscores, and hyphens."
  }
  
}

variable "location" {
  description = "The Azure region where the resource group will be created"
  type        = string
  default     = "centralindia" # Default value for the location
  validation {
    condition     = length(var.location) > 0
    error_message = "The location must not be empty."
  }
  
}

resource "azurerm_resource_group" "rg1" { 
  name     = var.group_name1
  location = var.location
}

resource "azurerm_resource_group" "rg2" {
  name     = var.group_name2
  location = var.location 
  
}

resource "azurerm_resource_group" "rg3" {
  name     = var.group_name3
  location = var.location
  
}
