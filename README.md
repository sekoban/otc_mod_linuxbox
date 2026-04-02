# T Cloud (a.k.a. OTC) simple ECS Linux module

* Module to create a simple ECS (default Ubuntu Linux).
* Requires:
 * Terraform v1.12.2
 * T Cloud (a.k.a. OTC) Terraform Provider 1.36.62

## Example usage

* the optional parts are commented out

```terraform
module "linuxbox" {
  # if you want to use a specific tag/version
  # source = "github.com/sekoban/otc_mod_linuxbox?ref=v0.1"
  source = "github.com/sekoban/otc_mod_linuxbox"

  name              = var.name
  #flavor            = "c4.large.4"
  #image_name        = "Standard_Ubuntu_24.04_amd64_uefi_latest"
  #availability_zone = "eu-de-02"
  #eip               = opentelekomcloud_vpc_eip_v1.eip.publicip[0].ip_address
  ssh_key_name      = var.name
  vpc_id            = var.vpc_id
  network_id        = var.network_id
  #tags              = var.tags
  #security_groups   = [opentelekomcloud_networking_secgroup_v2.sg.id]
  #ip_address        = "192.168.128.231"
  #kms_id            = data.opentelekomcloud_kms_key_v1.kms.id
  #system_disk_type  = "SSD"
  #system_disk_size  = 40
  #os_scheduler_hints_vars = [{
  #  group   = opentelekomcloud_compute_servergroup_v2.ecsgroup.id
  #  tenancy = "shared"
  #}]
}
```
