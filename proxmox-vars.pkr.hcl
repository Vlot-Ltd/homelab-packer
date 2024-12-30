
variable "proxmox_api_url" {
  type    = string
  default = "https://192.168.1.20:8006/api2/json"
}

variable "proxmox_node" {
  type    = string
  default = "proxmox"
}

variable "vm_cores" {
  type    = string
  default = "1"
}

variable "vm_cpu_type" {
  type    = string
  default = "host"
}

variable "vm_disk_format" {
  type    = string
  default = "raw"
}

variable "vm_disk_size" {
  type    = string
  default = "50G"
}

variable "vm_disk_type" {
  type    = string
  default = "scsi"
}

variable "vm_enable_qemu_agent" {
  type    = string
  default = "true"
}

variable "vm_memory" {
  type    = string
  default = "2048"
}

variable "vm_network_adapter_bridge" {
  type    = string
  default = "vmbr0"
}

variable "vm_network_adapter_model" {
  type    = string
  default = "virtio"
}

variable "vm_scsi_controller" {
  type    = string
  default = "virtio-scsi-pci"
}

variable "vm_sockets" {
  type    = string
  default = "2"
}

variable "vm_storage_pool" {
  type    = string
  default = "vmosstorage"
}
