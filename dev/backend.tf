terraform {
  backend "azurerm" {
   resource_group_name  = "delete"
   storage_account_name = "stousecommon"
   container_name       = "tfstate"
   key                  = "terraform.tfstate"
  }
}