#create RG for AKS
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#creating AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    #availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure" # CNI
  }
}

resource "azurerm_user_assigned_identity" "example" {
  name                = "my-user-assigned-identity"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_container_registry" "example" {
  name                = "myoptix"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false
}


resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = azurerm_container_registry.example.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_user_assigned_identity.example.principal_id
  skip_service_principal_aad_check = true
}