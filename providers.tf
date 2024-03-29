terraform {
  required_version = ">=1.6.6"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.24.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "~> 2.40.0"

    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

provider "azurerm" {
  features {}


  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}
