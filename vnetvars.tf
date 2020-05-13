#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Network - Variables
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*

# SPN Variables

variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}


variable "tags" {
    description =   "Resource Group/Resouce tags"
    type        =   map(string)
    default     =   {
        "created_by"    = "vamsi"
        "automated_by"  = "terraform"
        "deployed_from" = "jenkins"
        "env"           = "prod"
    }
}


variable "prefix" {
    
    description =   "Prefix to append to all resource names"
    type        =   string
    default     =   "demo"
}

variable "location" {
    description =   "Name of the location"
    type        =   string
    default     =   "East US"
}


variable "vnet_cidr" {
    description =   "CIDR Range of Vnet"
    type        =   string
    default     =   "10.0.0.0/16"
}

variable "security_rule" {
    description =   "Security Rule attributes for NSG"
    type        =   map(any)
    default     =   {
        "name"                          =  "Allow_Https"
        "priority"                      =  1000
        "direction"                     =  "Inbound"
        "access"                        =  "Allow"
        "protocol"                      =  "Tcp"
        "source_port_range"             =  "*"
        "destination_port_range"        =  443
        "source_address_prefix"         =  "*"
        "destination_address_prefix"    =  "*"

    }
}

