output "resource_group_name" {
    value = azurerm_resource_group.test-rg
    description = "Name of the resource group."
}

output "location_id" {
    value = azurerm_resource_group.test-rg.location
    description = "Location id of the resource group"
}