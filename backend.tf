terraform {
  backend "azurerm" {
    storage_account_name = "pax8cvmtfstate"
    container_name       = "cvmtfstate"
  }
}
