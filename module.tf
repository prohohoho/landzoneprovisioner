### Landing Zone Deployment modules ###

module "landing-zone-deployment" {
  source = "git::git@github.com:CloudVendingMachine/terraform-azure-landing-zone-deployment?ref=v2.0.1"

  company_short_name      = var.company_short_name
  environment             = var.environment
  environment_short_name  = var.environment_short_name
  location                = var.location
  location_short_name     = var.location_short_name
  subscription_id         = var.subscription_id
  tenant_id               = var.tenant_id
  secure_address_prefixes = ["192.168.0.64/26"]
  dmz_address_prefixes    = ["192.168.0.32/27"]
  gateway_subnet_range    = ["192.168.0.0/27"]
  address_space           = ["192.168.0.0/24"]
  backup_type             = var.backup_type
}

resource "random_string" "username" {
  length  = 10
  special = false
}

# This module will create an demo user in the AD. It will be crated when 'isdemo' variable is set to true
module "aduser" {
  source                 = "git::git@github.com:CloudVendingMachine/terraform-azure-ad-user-module.git?ref=v0.0.1"
  is_created             = var.isdemo == "true"
  company_short_name     = var.company_short_name
  environment_short_name = var.environment_short_name
  username               = random_string.username.result
  user_role_assignment_scopes = [
    module.landing-zone-deployment.baseline_rg.id,
    module.landing-zone-deployment.product_rg.id
  ]
}

## landing zone products  ###

# module "storage-account-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-storage-account-module"

#   for_each = { for x in local.storage_acc.storage_acc.list : x.name => x }

#   name                     = each.value.name
#   access_tier              = try(each.value.access_tier, local.storage_acc.storage_acc.access_tie)
#   account_kind             = try(each.value.account_kind, local.storage_acc.storage_acc.account_kind)
#   account_replication_type = try(each.value.account_replication_type, local.storage_acc.storage_acc.account_replication_type)
#   company_short_name       = var.company_short_name
#   location                 = var.location
#   environment_short_name   = var.environment_short_name
#   resource_group_name      = module.landing-zone-deployment.product_rg.name
#   subnet_id                = module.landing-zone-deployment.subnet.id
#   diagnostic_account_id    = module.landing-zone-deployment.diagnostics_id
# }


# module "container-registry-module-main" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-container-registry-module-main"

#   for_each = { for x in local.acr.acr : x.name => x }

#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   diag_sa                = module.landing-zone-deployment.diagnostics_id
#   location               = var.location
#   name                   = each.value.name
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   subnet_id              = module.landing-zone-deployment.subnet.id
# }

# module "keyvault-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-keyvault-module"

#   for_each = { for x in local.akv_config.akv_config.list : x.shortname => x }

#   resource_group_name         = module.landing-zone-deployment.product_rg.name
#   location                    = var.location
#   akv_name                    = each.value.shortname
#   enabled_for_disk_encryption = "true"
#   soft_delete_retention_days  = try(each.value.soft_delete_retention_days, local.akv_config.akv_defaults.soft_delete_retention_days)
#   purge_protection_enabled    = "false"
#   sku_name                    = each.value.sku_name
#   subnet_id                   = module.landing-zone-deployment.subnet.id
#   #diagsa                      = module.landing-zone-deployment.diagnostics_id
#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name

# }

###Compute

# module "windowsVMSS-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-windowsVMSS-module"

#   for_each = { for x in local.windows_vmss.windows_vmss_config : x.name => x }

#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   disk_encryption_set_id = module.landing-zone-deployment.disk_encryption_id
#   name                   = each.value.name
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   subnet_id              = module.landing-zone-deployment.subnet.id
#   image_sku              = each.value.image_sku
#   instance_number        = each.value.instance_number
#   disk_size_gb           = each.value.disk_size_gb
#   storage_account_type   = each.value.storage_account_type
#   vmss_sku               = each.value.vmss_sku
# }

# module "linuxVMSS-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-linuxVMSS-module"

#   for_each = { for x in local.linux_vmss.linux_vmss_config : x.name => x }

#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   disk_encryption_set_id = module.landing-zone-deployment.disk_encryption_id
#   name                   = each.value.name
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   subnet_id              = module.landing-zone-deployment.subnet.id
#   image_sku              = each.value.image_sku
#   instance_number        = each.value.instance_number
#   disk_size_gb           = each.value.disk_size_gb
#   storage_account_type   = each.value.storage_account_type
#   vmss_sku               = each.value.vmss_sku
#   offer                  = each.value.offer
#   publisher              = each.value.publisher
# }

# module "linux-vm-module-main" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-linux-vm-module-main"

#   for_each = { for x in local.linux_vm_config.vm_config.list : x.name => x }

#   depends_on = [module.landing-zone-deployment]

#   admin_username = try(each.value.admin_username, local.linux_vm_config.linux_vm_defaults.admin_username)
#   akv_id         = module.landing-zone-deployment.akv_id
#   # backup_policy_id              = module.landing-zone-deployment.pax8Backup.id
#   # company_short_name            = var.company_short_name
#   diagnostic_account_id  = module.landing-zone-deployment.diagnostics_id
#   disk_encryption_set_id = try(module.landing-zone-deployment.disk_encryption_id, null) #can be null
#   #environment_short_name        = var.environment_short_name
#   image_offer     = try(each.value.image_offer, local.linux_vm_config.linux_vm_defaults.image_offer)
#   image_publisher = try(each.value.image_publisher, local.linux_vm_config.linux_vm_defaults.image_publisher)
#   image_sku       = try(each.value.image_sku, local.linux_vm_config.linux_vm_defaults.image_sku)
#   image_version   = try(each.value.image_version, local.linux_vm_config.linux_vm_defaults.image_version)
#   location        = var.location
#   os_disk_size    = each.value.os_disk_size
#   os_hostname     = each.value.os_hostname
#   # recovery_vault_name           = module.landing-zone-deployment.recovery_vault_name.name
#   # recovery_vault_resource_group = module.landing-zone-deployment.recovery_vault_name.resource_group_name
#   resource_group_name = module.landing-zone-deployment.product_rg.name
#   size                = each.value.size
#   subnet_id           = module.landing-zone-deployment.subnet.id
#   # timezone                      = local.linux_vm_config.vm_config.linux_vm_defaults.timezone
#   vm_name       = each.value.name
#   managed_disks = each.value.managed_disks

# }


module "win-vm-module-main" {
  source = "git::git@github.com:CloudVendingMachine/terraform-azure-win-vm-module-main?ref=v0.0.1"

  for_each = { for x in local.win_vm_config.vm_config.list : x.name => x }


  admin_username                = try(each.value.admin_username, local.win_vm_config.win_vm_defaults.admin_username)
  akv_id                        = module.landing-zone-deployment.akv_id
  company_short_name            = var.company_short_name
  diagnostic_account_id         = module.landing-zone-deployment.diagnostics_id
  disk_encryption_set_id        = try(module.landing-zone-deployment.disk_encryption_id, null) #can be null
  environment_short_name        = var.environment_short_name
  image_offer                   = try(each.value.image_offer, local.win_vm_config.win_vm_defaults.image_offer)
  image_publisher               = try(each.value.image_publisher, local.win_vm_config.win_vm_defaults.image_publisher)
  image_sku                     = try(each.value.image_sku, local.win_vm_config.win_vm_defaults.image_sku)
  image_version                 = try(each.value.image_version, local.win_vm_config.win_vm_defaults.image_version)
  location                      = var.location
  os_disk_size                  = each.value.os_disk_size
  os_hostname                   = each.value.os_hostname
  enable_backup                 = var.backup_type == "AzureBackups" ? true : false
  recovery_vault_name           = try(module.landing-zone-deployment.recovery_vault_name.name, null)
  recovery_vault_resource_group = try(module.landing-zone-deployment.recovery_vault_name.resource_group_name, null)
  backup_policy_id              = try(module.landing-zone-deployment.pax8Backup.id, null)
  resource_group_name           = module.landing-zone-deployment.product_rg.name
  size                          = each.value.size
  subnet_id                     = module.landing-zone-deployment.subnet.id
  timezone                      = local.win_vm_config.vm_config.win_vm_defaults.timezone
  vm_name                       = each.value.name
  managed_disks                 = each.value.managed_disks

}

#Database /  analytics

# module "cosmosdb-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-cosmosdb-module"

#   for_each = { for x in local.cosmos_db.cosmos_db : x.name => x }

#   depends_on = [module.landing-zone-deployment]

#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   name                   = each.value.name
#   database               = each.value.database
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   throughput             = each.value.throughput
# }

# module "mariadb-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-mariadb-module"

#   for_each = { for x in local.mariadb.mariadb : x.name => x }

#   depends_on = [module.landing-zone-deployment]

#   akv_id                 = module.landing-zone-deployment.akv_id
#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   name                   = each.value.name
#   database               = each.value.database
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   diag_sa                = module.landing-zone-deployment.diagnostics_id
#   sku                    = each.value.sku
#   subnet_id              = module.landing-zone-deployment.subnet.id
# }

# module "mssql-server-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-mssql-server-module"

#   for_each = { for x in local.mssql.mssql : x.sql_server_name => x }

#   depends_on = [module.landing-zone-deployment]

#   administator_username  = each.value.administator_username
#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   sql_server_name        = each.value.sql_server_name
#   database               = each.value.database
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   diag_sa                = module.landing-zone-deployment.diagnostics_id
#   subnet_id              = module.landing-zone-deployment.subnet.id
# }


# module "postgres-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-postgres-module"

#   for_each = { for x in local.postgres_single_db.postgres : x.name => x }

#   depends_on = [module.landing-zone-deployment]

#   sku_name               = each.value.sku
#   storage_mb             = each.value.storage_mb
#   akv_id                 = module.landing-zone-deployment.akv_id
#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   name                   = each.value.name
#   database               = each.value.database
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   diag_sa                = module.landing-zone-deployment.diagnostics_id
#   subnet_id              = module.landing-zone-deployment.subnet.id
# }


# module "mysql-module" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-mysql-module"

#   for_each = { for x in local.mysql.mysql : x.name => x }

#   depends_on = [module.landing-zone-deployment]

#   akv_id                 = module.landing-zone-deployment.akv_id
#   sku_name               = each.value.sku
#   storage_mb             = each.value.storage_mb
#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   name                   = each.value.name
#   database               = each.value.database
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   diag_sa                = module.landing-zone-deployment.diagnostics_id
#   subnet_id              = module.landing-zone-deployment.subnet.id
# }

# module "data-factory-module-main" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-data-factory-module-main"

#   for_each = { for x in local.adf.adf : x.name => x }

#   environment_short_name          = var.environment_short_name
#   company_short_name              = var.company_short_name
#   diag_sa                         = module.landing-zone-deployment.diagnostics_id
#   location                        = var.location
#   name                            = each.value.name
#   resource_group_name             = module.landing-zone-deployment.product_rg.name
#   subnet_id                       = module.landing-zone-deployment.subnet.id
#   self_hosted_integration_runtime = each.value.self_hosted_integration_runtime
# }

# # Security #####

# module "sentinel-module-main" {
#   source     = "git::git@github.com:CloudVendingMachine/terraform-azure-sentinel-module-main"
#   depends_on = [module.landing-zone-deployment]

#   environment_short_name = var.environment_short_name
#   company_short_name     = var.company_short_name
#   location               = var.location
#   resource_group_name    = module.landing-zone-deployment.product_rg.name

# }

# module "firewall" {
#   source = "git::git@github.com:CloudVendingMachine/terraform-azure-firewall-module"

#   for_each   = { for x in local.azure_firewall.azure_firewall : x.resource_group_name => x }
#   depends_on = [module.landing-zone-deployment]

#   environment_short_name = var.environment_short_name
#   #company_short_name      = var.company_short_name
#   location            = var.location
#   location_short_name = var.location_short_name
#   resource_group_name = module.landing-zone-deployment.product_rg.name
#   sku_name            = each.value.sku_name
#   sku_tier            = each.value.sku_tier
#   subnet_name         = module.landing-zone-deployment.subnet.name
#   vnet_name           = module.landing-zone-deployment.vnet.name
# }

# module "aks-deployment" {
#   source     = "git::git@github.com:CloudVendingMachine/terraform-azure-aks-module"
#   depends_on = [module.landing-zone-deployment]

#   for_each               = { for x in local.aks_config.aks_config : x.name => x }
#   company_short_name     = var.company_short_name
#   environment_short_name = var.environment_short_name
#   location               = var.location
#   dns_prefix             = each.value.dns_prefix
#   name                   = each.value.name
#   resource_group_name    = module.landing-zone-deployment.product_rg.name
#   #subnet_id               = module.landing-zone-deployment.subnet.id
#   node_rg_name   = each.value.node_rg
#   aks_node_pools = each.value.aks_node_pool
# }

# module "azure-migrate" {
#   source                 = "git::git@github.com:CloudVendingMachine/terraform-azure-migrate-module.git"
#   company_short_name     = var.company_short_name
#   environment            = var.environment
#   environment_short_name = var.environment_short_name
#   location               = var.location
#   location_short_name    = var.location_short_name

#   migrate_resource_name     = local.migrate_config.migrate_resource_name
#   migrate_resource_group_id = module.landing-zone-deployment.product_rg.id
# }
