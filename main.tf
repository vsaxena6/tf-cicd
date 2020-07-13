#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*                 Root Module                         *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

# Remote Backend

terraform {
    backend "azurerm" {
        resource_group_name     =   "Jenkins"
        storage_account_name    =   "tfbackend2020"
        container_name          =   "tfremote"
        key                     =   "terraform.tfstate"
    }
}

# Provider Block

provider "azurerm" {
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

// module "provisioners" {
//     source  =   "./azure/provisioners-example"
// }

// module "winvm" {
//     source = "./azure/windowsVM"
// }

module "linuxvm" {
    source  =   "./azure/linuxVM-test"
}

