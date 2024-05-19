resource "azurerm_resource_group" "rg" {
  for_each = var.vnets

  name     = each.value.resource_group_name
  location = each.value.location
}

resource "azurerm_virtual_network" "vnet01" {
  for_each = var.vnets

  name                = each.value.vnetname
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  # resource_group_name = azurerm_resource_group.rg[each.key].name
  address_space       = each.value.address_space
 depends_on = [ azurerm_resource_group.rg ]
  dynamic "subnet" {
    for_each = each.value.subnets

    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
    }
  }
}


