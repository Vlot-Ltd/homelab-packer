variable "proxmox_api_url" {
    type        = string
    description = "Proxmox API URL"
    sensitive   = true
}

variable "proxmox_node" {
    type        = string
    description = "Proxmox node"
    sensitive   = true
}

variable "proxmox_token" {
    type        = string
    description = "Proxmox API token"
    sensitive   = true
}

variable "proxmox_user" {
    type        = string
    description = "Proxmox API user"
    sensitive   = true
}

variable "ssh_password" {
    type        = string
    description = "SSH password"
    sensitive   = true
}

variable "ssh_username" {
    type        = string
    description = "SSH username"
    sensitive   = true
}

variables "vm_cores" {
    type        = string
    description = "Number of CPU cores"
    default     = "1"
}

variable "cpu_type" {
    type        = string
    description = "CPU type"
    default     = "host"
}

variable "vm_disk_format" {
    type        = string
    description = "Disk format"
    default     = "raw"
}

variable "vm_disk_size" {
    type        = string
    description = "Disk size"
    default     = "50G"
}

variable "vm_disk_type" {
    type        = string
    description = "Disk type"
    default     = "scsi"
}

variable "vm_enable_qemu_agent" {
    type        = string
    description = "Enable QEMU agent"
    default     = "true"
}

variable "vm_memory" {
    type        = string
    description = "Memory size"
    default     = "2048"
}

variable "vm_network_adapter_bridge" {
    type        = string
    description = "Network adapter bridge"
    default     = "vmbr0"
}

variable "vm_network_adapter_model" {
    type        = string
    description = "Network adapter model"
    default     = "virtio"
}

variable "vm_scsi_controller" {
    type        = string
    description = "SCSI controller"
    default     = "virtio-scsi-pci"
}

variable "vm_sockets" {
    type        = string
    description = "Number of sockets"
    default     = "2"
}

variable "vm_storage_pool" {
    type        = string
    description = "Storage pool"
    default     = "vmosstorage"
}