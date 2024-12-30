packer {
  required_plugins {
    proxmox = {
      version = ">= 1.2.2"
      source  = "github.com/hashicorp/proxmox"
    }
    git = {
      source  = "github.com/ethanmdavidson/git"
      version = ">= 0.6.3"
    }
  }
}

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

variable "vm_cores" {
    type        = string
    description = "Number of CPU cores"
    default     = "1"
}

variable "vm_cpu_type" {
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

data "git-repository" "cwd" {}

locals {
  build_by          = "Built by: HashiCorp Packer ${packer.version}"
  build_date        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_version     = data.git-repository.cwd.head
  vm_os             = "l26"

  http_directory_2204 = "ubuntu/config2204"
  iso_filename_2204   = "local:isostorage/ubuntu-22.04.5-live-server-amd64.iso"
  iso_checksum_2204   = "9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0" #pragma: allowlist secret
  proxmox_vmid_2204   = "900"
  template_des_2204   = "Ubuntu 22.04.5 x86_64 template.\nVersion: ${local.build_version}\nBuilt on: ${local.build_date}\n${local.build_by}.\nUsername: proxmox"
  template_name_2204  = "tpl-ubuntu-2204"

  http_directory_2404 = "ubuntu/config2404"
  iso_filename_2404   = "local:isostorage/ubuntu-24.04.1-live-server-amd64.iso"
  iso_checksum_2404   = "e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9" #pragma: allowlist secret
  proxmox_vmid_2404   = "901"
  template_des_2404   = "Ubuntu 24.04.1 x86_64 template.\nVersion: ${local.build_version}\nBuilt on: ${local.build_date}\n${local.build_by}.\nUsername: proxmox"
  template_name_2404  = "tpl-ubuntu-2404"

}

source "proxmox-iso" "ubuntu-2204" {
  boot_command            = ["c", "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ", "<enter><wait>", "initrd /casper/initrd<enter><wait>", "boot<enter>"]
  boot_wait               = "10s"
  cloud_init              = true
  cloud_init_storage_pool = "${var.vm_storage_pool}"
  cores                   = "${var.vm_cores}"
  cpu_type                = "${var.vm_cpu_type}"
  disks {
    disk_size         = "${var.vm_disk_size}"
    format            = "${var.vm_disk_format}"
    storage_pool      = "${var.vm_storage_pool}"
    type              = "${var.vm_disk_type}"
  }
  http_directory           = "${local.http_directory_2204}"
  insecure_skip_tls_verify = true
  iso_checksum             = "${local.iso_checksum_2204}"
  iso_file                 = "${local.iso_filename_2204}"
  memory                   = "${var.vm_memory}"
  network_adapters {
    bridge = "${var.vm_network_adapter_bridge}"
    model  = "${var.vm_network_adapter_model}"
  }
  node                 = "${var.proxmox_node}"
  os                   = "${local.vm_os}"
  proxmox_url          = "${var.proxmox_api_url}"
  qemu_agent           = "${var.vm_enable_qemu_agent}"
  scsi_controller      = "${var.vm_scsi_controller}"
  sockets              = "${var.vm_sockets}"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "20m"
  ssh_username         = "${var.ssh_username}"
  template_description = "${local.template_des_2204}"
  template_name        = "${local.template_name_2204}"
  token                = "${var.proxmox_token}"
  unmount_iso          = true
  username             = "${var.proxmox_user}"
  vm_id                = "${local.proxmox_vmid_2204}"
}

source "proxmox-iso" "ubuntu-2404" {
  boot_command            = ["c", "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ", "<enter><wait>", "initrd /casper/initrd<enter><wait>", "boot<enter>"]
  boot_wait               = "10s"
  cloud_init              = true
  cloud_init_storage_pool = "${var.vm_storage_pool}"
  cores                   = "${var.vm_cores}"
  cpu_type                = "${var.vm_cpu_type}"
  disks {
    disk_size         = "${var.vm_disk_size}"
    format            = "${var.vm_disk_format}"
    storage_pool      = "${var.vm_storage_pool}"
    type              = "${var.vm_disk_type}"
  }
  http_directory           = "${local.http_directory_2404}"
  insecure_skip_tls_verify = true
  iso_checksum             = "${local.iso_checksum_2404}"
  iso_file                 = "${local.iso_filename_2404}"
  memory                   = "${var.vm_memory}"
  network_adapters {
    bridge = "${var.vm_network_adapter_bridge}"
    model  = "${var.vm_network_adapter_model}"
  }
  node                 = "${var.proxmox_node}"
  os                   = "${local.vm_os}"
  proxmox_url          = "${var.proxmox_api_url}"
  qemu_agent           = "${var.vm_enable_qemu_agent}"
  scsi_controller      = "${var.vm_scsi_controller}"
  sockets              = "${var.vm_sockets}"
  ssh_password         = "${var.ssh_password}"
  ssh_timeout          = "20m"
  ssh_username         = "${var.ssh_username}"
  template_description = "${local.template_des_2404}"
  template_name        = "${local.template_name_2404}"
  token                = "${var.proxmox_token}"
  unmount_iso          = true
  username             = "${var.proxmox_user}"
  vm_id                = "${local.proxmox_vmid_2404}"
}

build {
  
  sources = [
    "source.proxmox-iso.ubuntu-2204",
    "source.proxmox-iso.ubuntu-2404",
  ]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done"]
  }

  provisioner "shell" {
    inline = [
      "sudo rm -f /etc/cloud/cloud.cfg.d/99-installer.cfg",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo cloud-init clean"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "TEMPLATE=${source.template_name}"
    ]
    inline = [
      "echo $(date +%Y%m%d-%H%M%S)-$TEMPLATE > /home/proxmox/packer.build"
    ]
  }

  provisioner "file" {
    source = "ubuntu/scripts/hardening.sh"
    destination = "~/packer-hardening.sh"
  }

  provisioner "shell" {
    inline = [
      "sudo bash ~/packer-hardening.sh"
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "CHEF_LICENSE=accept-silent"
    ]
    inline = [
      "curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec",
      "cd ~",
      "git clone https://github.com/dev-sec/linux-baseline.git",
      "inspec exec linux-baseline --reporter=cli json:packer_$(hostname)_$(date +%Y%m%d_%H%M%S)_inspec.json"
    ]
    valid_exit_codes = [ 0, 100]
  }
}