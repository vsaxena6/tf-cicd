# #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# # Root Folder - Outputs
# #*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*


output "names" {
    description = "Resource Names"
    value = {
        "resource-group-name" =     azurerm_resource_group.rg.name
        "location"            =     azurerm_resource_group.rg.location
        "vnet-name"           =     azurerm_virtual_network.vnet.name
        "subnet-name"         =     azurerm_subnet.sn.name
        "nsg-name"            =     azurerm_network_security_group.nsg.name
        "vm-name"             =     azurerm_linux_virtual_machine.vm.name
    }
}
