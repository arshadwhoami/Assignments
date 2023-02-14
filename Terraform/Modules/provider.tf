terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "ecc63087-f244-45d0-9551-f4c5f9e18784"
  tenant_id       = "687f51c3-0c5d-4905-84f8-97c683a5b9d1"
}