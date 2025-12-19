provider "azurerm" {
  features {}

  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.tag
  }
}

resource "azurerm_container_registry" "tammpoccontainerregistry" {
  name                     = var.acr_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Basic"  # You can change this to Standard, Premium, etc.
  admin_enabled            = true     # Enable admin user access to the registry
}


resource "azurerm_kubernetes_cluster" "tamm_app" {
  name                = "tamm-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "tammappdns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.tag
  }
}

resource "azurerm_kubernetes_cluster" "tamm_svc" {
  name                = "tamm-svc"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "tammsvcdns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = var.tag
  }
}

output "tamm_app_kube_config" {
  value     = azurerm_kubernetes_cluster.tamm_app.kube_config_raw
  sensitive = true
}

output "tamm_svc_kube_config" {
  value     = azurerm_kubernetes_cluster.tamm_svc.kube_config_raw
  sensitive = true
}
