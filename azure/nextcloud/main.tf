# Created by: Manoj Agarwal
# Version: 1.0.0

# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.37.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Variables
variable "resource_group_name"     { default = "nextcloud-rg" }
variable "location"                { default = "Central India" }
variable "storage_account_name"    { default = "nextcloudstorage006" }
variable "container_image"         { default = "nextcloud" }

# 1. Resource Group
resource "azurerm_resource_group" "nextcloud_rg" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Storage Account
resource "azurerm_storage_account" "nextcloud_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.nextcloud_rg.name
  location                 = azurerm_resource_group.nextcloud_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 3. Blob Container
resource "azurerm_storage_container" "nextcloud_container" {
  name                  = "nextcloudfiles"
  storage_account_id   = azurerm_storage_account.nextcloud_storage.id
  container_access_type = "private"
}

# 4. Log Analytics Workspace (Optional for ACA)
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "log-${var.resource_group_name}"
  location            = azurerm_resource_group.nextcloud_rg.location
  resource_group_name = azurerm_resource_group.nextcloud_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# 5. Container App Environment
resource "azurerm_container_app_environment" "nextcloud_env" {
  name                       = "nextcloud-env"
  location                   = azurerm_resource_group.nextcloud_rg.location
  resource_group_name        = azurerm_resource_group.nextcloud_rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
}

# 6. Container App
resource "azurerm_container_app" "nextcloud_app" {
  name                          = "nextcloud-app"
  container_app_environment_id = azurerm_container_app_environment.nextcloud_env.id
  resource_group_name           = azurerm_resource_group.nextcloud_rg.name
  #location                      = azurerm_resource_group.nextcloud_rg.location
  revision_mode                 = "Single"

  template {
    container {
      name   = "nextcloud"
      image  = var.container_image
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}

resource "azurerm_container_group" "mariadb" {
  name                = "mariadb"
  location            = azurerm_resource_group.nextcloud_rg.location
  resource_group_name = azurerm_resource_group.nextcloud_rg.name
  os_type             = "Linux"

  container {
    name   = "mariadb"
    image  = "mariadb:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 3306
      protocol = "TCP"
    }

    environment_variables = {
      MYSQL_ROOT_PASSWORD = "password123"
      MYSQL_DATABASE      = "maaznextclouddb"
      MYSQL_USER          = "maaznextcloud"
      MYSQL_PASSWORD      = "password123"
    }
  }

  ip_address_type = "Public"  # or "Private" if in same VNet
  dns_name_label = "mariadbnextcloud" 
}

