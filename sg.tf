resource "opentelekomcloud_networking_secgroup_v2" "sg" {
  name                 = "${var.name}_sg"
  description          = "${var.name} security group"
  delete_default_rules = true
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_group_in" {
  direction         = "ingress"
  protocol          = ""
  ethertype         = "IPv4"
  remote_group_id   = opentelekomcloud_networking_secgroup_v2.sg.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg.id
  description       = "Allow all communication within ${var.name} sg on any port."
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_group_out" {
  direction         = "egress"
  protocol          = ""
  ethertype         = "IPv4"
  remote_group_id   = opentelekomcloud_networking_secgroup_v2.sg.id
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg.id
  description       = "Allow all communication within ${var.name} sg on any port."
}

resource "opentelekomcloud_networking_secgroup_rule_v2" "sg_internet" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = opentelekomcloud_networking_secgroup_v2.sg.id
  description       = "Allow all outgoing communication from the ${var.name} sg."
}
