resource "random_integer" "random_suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "example" {
  name     = "rg_cloud_shell_Ryan_LE-${random_integer.random_suffix.result}"
  location = "France Central"
}

resource "azurerm_app_service_plan" "example" {
  name                = "asp_cloud_shell_Ryan_LE-${random_integer.random_suffix.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Windows"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "webapp_cloud_shell_Ryan_LE-${random_integer.random_suffix.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    windows_fx_version = "WINDOWS|latest"
  }
}
