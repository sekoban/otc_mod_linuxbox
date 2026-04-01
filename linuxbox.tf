# opentelekomcloud_compute_keypair_v2
# https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/1.36.62/docs/data-sources/compute_keypair_v2
#data "opentelekomcloud_compute_keypair_v2" "keypair" {
#  name = var.ssh_key_name
#}

# opentelekomcloud_images_image_v2
# https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/1.36.62/docs/data-sources/images_image_v2
data "opentelekomcloud_images_image_v2" "imgdata" {
  name = var.image_name
}

# opentelekomcloud_ecs_instance_v1
# https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/1.36.62/docs/resources/ecs_instance_v1
resource "opentelekomcloud_ecs_instance_v1" "linuxbox" {
  name                        = var.name
  flavor                      = var.flavor
  image_id                    = data.opentelekomcloud_images_image_v2.imgdata.id
  availability_zone           = var.availability_zone
  key_name                    = var.ssh_key_name
  vpc_id                      = var.vpc_id
  system_disk_type            = var.system_disk_type
  system_disk_size            = var.system_disk_size
  system_disk_kms_id          = var.kms_id != "" ? var.kms_id : null
  delete_disks_on_termination = true
  tags                        = var.tags

  security_groups = concat([
    opentelekomcloud_networking_secgroup_v2.sg.id
  ], var.security_groups)

  nics {
    network_id = var.network_id
    ip_address = var.ip_address != "" ? var.ip_address : null
  }

  dynamic "os_scheduler_hints" {
    for_each = var.os_scheduler_hints_vars
    content {
      group   = os_scheduler_hints.value.group
      tenancy = os_scheduler_hints.value.tenancy
    }
  }

  lifecycle {
    ignore_changes = [
      image_id
    ]
  }
}

# opentelekomcloud_networking_floatingip_associate_v2
# https://registry.terraform.io/providers/opentelekomcloud/opentelekomcloud/1.36.62/docs/resources/networking_floatingip_associate_v2
resource "opentelekomcloud_networking_floatingip_associate_v2" "eip_association" {
  floating_ip = var.eip #opentelekomcloud_vpc_eip_v1.eip.publicip[0].ip_address
  port_id     = opentelekomcloud_ecs_instance_v1.linuxbox.nics.0.port_id
}
