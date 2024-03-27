terraform {

required_providers {

azurerm = {

source = "hashicorp/azurerm"

version = "~> 3.0.0"

}

required_version = ">= 0.14.9"

}

provider "azurerm" {

features {}

# b. Code pour la ressource random_integer
resource "random_integer" "random_suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${var.Ryan}-${random_integer.random_suffix.result}"
  location = var.location
}

resource "azurerm_app_service_plan" "example" {
  name                = "asp-${var.Ryan}-${random_integer.random_suffix.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "example" {
  name                = "webapp-${var.Ryan}-${random_integer.random_suffix.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  site_config {
    application_stack {
      java_server       = "JAVA"
      java_version      = "java17"
      java_server_version = "17"
    }
  }
}

