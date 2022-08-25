variable "region" {
    description = "Region"
    type = string  
}

variable "vm_password" {
    description = "6-20 characters. at least 1 lower, 1 cap, 1 number and 1 special char"
    type = string
    sensitive = true
}

variable "storage_size" {
    description = "database storage size"
    type = number
    default = 5120
}

variable "additional_tags" {
    type = map(string)
    default = {}
}

variable "node_count" {
    type = number
    default = null  
}

variable "load_level" {
    type = string
    default = ""
}