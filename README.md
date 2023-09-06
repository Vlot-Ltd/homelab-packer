```sh
packer validate -var-file=proxmox-vars.pkr.hcl -var-file=proxmox-secrets.pkr.hcl ubuntu/22.04/ubuntu-22.04.json.pkr.hcl
packer build -var-file=proxmox-vars.pkr.hcl -var-file=proxmox-secrets.pkr.hcl -force ubuntu/22.04/ubuntu-22.04.json.pkr.hcl
```