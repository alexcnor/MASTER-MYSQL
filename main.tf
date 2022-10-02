terraform {
  backend "azurerm" {
    storage_account_name = "{{StorageAccount}}"
    container_name       = "{{ContainerName}}"
    access_key           = "{{InfraStorageKey}}"
    key                  = "{{StateName}}"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.67.0"
    }
  }
}

resource "azurerm_mysql_server" "mysql" {
  name                = "{{client}}-{{environment}}"
  location            = "eastus2"
  resource_group_name = "{{resourceGroup}}"

  administrator_login          = "{{adminUser}}"
  administrator_login_password = "{{adminPass}}"

  sku_name   = "{{tier}}"
  storage_mb = tonumber("{{storage}}")
  version    = "{{version}}"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}
