provider "azurerm" {
  features {}  
}

resource "azurerm_resource_group" "example" {
  name     = "resourceGroupName"
  location = "eastus"
}

resource "azurerm_app_service_plan" "example" {
  name                = "appserviceplanname"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "appservicename"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {  
    http2_enabled = false
    ftps_state = "FtpsOnly"
    minimum_tls_version = "1.0"

    remote_debugging_enabled = true
    remote_debugging_version = "VS2017"

    php_version = "5.6"
    python_version = "2.7"    

    cors {
      allowed_origins = ["*"]
    }
  }

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
  }
}
