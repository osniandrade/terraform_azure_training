output "vm_public_ip_address" {
    value = azurerm_linux_virtual_machine.lab-bastion.public_ip_addresses[0]
}
output "db_server_endpoint" {
    value = module.database-server.server_fqdn
}

output "load-balancer-public-ip" {
    value = module.load-balancer.lb_public_ip_address
}