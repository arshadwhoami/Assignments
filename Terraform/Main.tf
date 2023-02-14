provider "azurerm" {
  features {}
  # subscription_id = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  # tenant_id       = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

module "resourcegroup" {
  source         = "./modules/resourcegroup"
  resource_group_name           = var.resource_group_name
  resource_group_location       = var.resource_group_location
}

module "networking" {
  source         = "./modules/vnet"
  location       = var.resource_group_location
  resource_group = var.resource_group_name
  vnetcidr       = var.vnetcidr
  websubnetcidr  = var.websubnetcidr
  appsubnetcidr  = var.appsubnetcidr
  dbsubnetcidr   = var.dbsubnetcidr
  depends_on = [
    module.resourcegroup
  ]
}

module "securitygroup" {
  source         = "./modules/NSG"
  location       = var.resource_group_location
  resource_group_name = var.resource_group_name 
  web_subnet_id  = module.networking.websubnet_id
  app_subnet_id  = module.networking.appsubnet_id
  db_subnet_id   = module.networking.dbsubnet_id
  depends_on = [
    module.networking
  ]
}

module "compute" {
  source         = "./modules/VMs"
  resource_group_location = var.resource_group_location
  resource_group_name = var.resource_group_name
  web_subnet_id = module.networking.websubnet_id
  app_subnet_id = module.networking.appsubnet_id
  web_host_name = var.web_host_name
  web_username = var.web_username
  web_os_password = var.web_os_password
  app_host_name = var.app_host_name
  app_username = var.app_username
  app_os_password = var.app_os_password
  depends_on = [
    module.resourcegroup,
    module.securitygroup
  ]
}

module "database" {
  source = "./modules/database"
  resource_group_location = var.resource_group_location
  resource_group_name = var.resource_group_name
  primary_database = var.primary_database
  primary_database_version = var.primary_database_version
  primary_database_admin = var.primary_database_admin
  primary_database_password = var.primary_database_password
  depends_on = [
    module.compute
  ]
}