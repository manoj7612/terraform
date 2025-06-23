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
  
}

resource "azurerm_resource_group" "rg" {
    name = var.group_name
    location = "Central India"
}
