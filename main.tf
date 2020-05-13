#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Root Module
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

# Remote Backend

terraform {
    backend "azurerm" {}
}

# Provider Block

provider "azurerm" {
    version         =   ">= 2.6"
    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    
    features {
        virtual_machine {
            delete_os_disk_on_deletion = true
        }
    }
}

resource "azurerm_resource_group" "rg" {
    name        =       terraform.workspace == "default" ? "devrg" : "prodrg"
    location    =       "South India"
}




