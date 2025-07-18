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

variable "group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "RGTest" # Default value for the resource group name
  validation {
    condition     = length(var.group_name) > 0
    error_message = "The resource group name must not be empty."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.group_name))
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

resource "azurerm_resource_group" "rg" { 
  name     = var.group_name
  location = var.location
}

