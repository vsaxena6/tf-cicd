#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Create Network Infrastructure
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

# Resource Group

resource "azurerm_resource_group" "rg" {
    name                        =       "${var.prefix}-rg"
    location                    =       var.location
    tags                        =       var.tags
}

# Virtual Network 

resource "azurerm_virtual_network" "vnet" {
    name                        =       "${var.prefix}-vnet"
    resource_group_name         =       azurerm_resource_group.rg.name
    location                    =       azurerm_resource_group.rg.location
    address_space               =       [var.vnet_cidr]
    tags                        =       var.tags
}

# Subnet

resource "azurerm_subnet" "sn" {
    name                        =       "${var.prefix}-sn"
    resource_group_name         =       azurerm_resource_group.rg.name
    virtual_network_name        =       azurerm_virtual_network.vnet.name
    address_prefixes            =       [cidrsubnet(var.vnet_cidr,8,1)]
}

# Network Security Group

resource "azurerm_network_security_group" "nsg" {
    name                        =       "${var.prefix}-nsg"
    resource_group_name         =       azurerm_resource_group.rg.name
    location                    =       azurerm_resource_group.rg.location
    tags                        =       var.tags

    security_rule {
    name                        =       var.security_rule["name"]
    priority                    =       var.security_rule["priority"]
    direction                   =       var.security_rule["direction"]
    access                      =       var.security_rule["access"]
    protocol                    =       var.security_rule["protocol"]
    source_port_range           =       var.security_rule["source_port_range"]
    destination_port_range      =       var.security_rule["destination_port_range"]
    source_address_prefix       =       var.security_rule["source_address_prefix"]
    destination_address_prefix  =       var.security_rule["destination_address_prefix"]
    
    }
}

# Subnet-NSG Association

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
    subnet_id                   =       azurerm_subnet.sn.id
    network_security_group_id   =       azurerm_network_security_group.nsg.id
}

