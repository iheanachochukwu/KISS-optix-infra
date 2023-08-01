provider "azurerm" {
  features {}
}

## provider config supports new versions in latest_provider_directory to support resources with new provider versions.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.32.0"
    }
  }
  required_version = ">= 1.1.0"
}






// provider "azurerm" {
//   features {}
// }

// terraform {
//   required_providers {
//     azurerm = {
//       source = "hashicorp/azurerm"
//       version = "2.39.0"
//     }
//   }
// }