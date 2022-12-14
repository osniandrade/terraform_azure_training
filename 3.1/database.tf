resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

locals {
    ip = {
        private = {
            start_ip = cidrhost(azurerm_subnet.lab-private.address_prefixes[0], 0),
            end_ip = cidrhost(azurerm_subnet.lab-private.address_prefixes[0], 255)
        }
        bastion = {
            start_ip = azurerm_linux_virtual_machine.lab-bastion.private_ip_address,
            end_ip = azurerm_linux_virtual_machine.lab-bastion.private_ip_address
        }
    }
}

module "database-server" {
  source  = "Azure/postgresql/azurerm"
  version = "2.1.0"
  
  location = local.region
  resource_group_name = azurerm_resource_group.lab.name
  server_name = "aztf-labs-psqlserver-${random_integer.suffix.result}-mod"
  sku_name = "B_Gen5_1"
  server_version = "11"
  storage_mb = var.storage_size
  ssl_enforcement_enabled = false

  administrator_login = "psqladmin"
  administrator_password = azurerm_key_vault_secret.lab-db-pwd.value

  db_names = ["aztf-labs-db"]
  db_charset = "UTF8"
  db_collation = "English_United States.1252"

  tags = local.common_tags
}

resource "azurerm_postgresql_firewall_rule" "lab-rule" {
  for_each = local.ip
  name                = "aztf-labs-fwrule-${each.key}"
  resource_group_name = azurerm_resource_group.lab.name
  server_name         = module.database-server.server_name
  start_ip_address = each.value.start_ip
  end_ip_address = each.value.end_ip
}
