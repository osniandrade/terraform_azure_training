output "lb_backend_address_pool_id" {
    value = azurerm_lb_backend_address_pool.lab.id
}

output "lb_public_ip_address" {
    value = azurerm_public_ip.lab-lb.ip_address
}