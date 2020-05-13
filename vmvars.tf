#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
# Variables
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*


# NIC 

variable "private_ip_address_allocation" {
    default         =       "Dynamic"
}

# VM 

variable "vmSize" {
    default         =       "Standard_D2_v3"
}

variable "computer_name" {
    default         =       "Linuxvm"
}

variable "admin_username" {
    default         =       "linuxadmin"
}

variable "admin_password" {
    default         =       "P@$$w0rD2020*"
}

variable "os_disk_caching" {
    default         =       "ReadWrite"
}

variable "os_disk_storage_account_type" {
    default         =       "StandardSSD_LRS"
}

variable "os_disk_size_gb" {
    default         =       64
}

variable "publisher" {
    default         =       "Canonical"
}

variable "offer" {
    default         =       "UbuntuServer"
}

variable "sku" {
    default         =       "16.04-LTS"
}

variable "vm_image_version" {
    default         =       "latest"
}
