variable "name" {
  type        = string
  description = "(Required, String) A unique name for the instance."
}

variable "image_name" {
  type        = string
  description = "(Required, String, ForceNew) Will be used to get the Image ID of the desired image for the server. Changing this creates a new server."
  default     = "Standard_Ubuntu_24.04_amd64_uefi_latest"
}

variable "ssh_key_name" {
  type        = string
  description = "(Required, String, ForceNew) The name of the keypair."
}

variable "flavor" {
  type        = string
  description = "(Required, String) The name of the desired flavor for the server."
  default     = "s3.medium.2"
}

variable "availability_zone" {
  type        = string
  description = "(Required, String, ForceNew) The availability zone in which to create the server."
  default     = "eu-de-01"
  #  DE eu-de:  "eu-de-01", "eu-de-02", "eu-de-03"
  #  NL eu-nl:  "eu-nl-01", "eu-nl-02", "eu-nl-03"
  #  CH eu-ch2: "eu-ch2a", "eu-ch2b"
}

variable "kms_id" {
  type        = string
  description = "(Optional, String, ForceNew) The Encryption KMS ID of the system disk. Changing this creates a new server."
  default     = ""
}

variable "security_groups" {
  type        = list(string)
  description = "(Optional, List) An array of one or more security group IDs to associate with the server. If this parameter is left blank, the default security group is bound to the ECS by default."
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "(Required, String, ForceNew) The ID of the desired VPC for the server. Changing this creates a new server."
}

variable "network_id" {
  type        = string
  description = "(Required, String, ForceNew) The network UUID to attach to the server. Changing this creates a new server."
}

variable "ip_address" {
  type        = string
  description = "(Optional, String, ForceNew) Specifies a fixed IPv4 address to be used on this network. Changing this creates a new server."
  default     = ""
}

variable "system_disk_type" {
  type        = string
  description = "Optional, String, ForceNew) The system disk type of the server. Changing this creates a new server. Options are limited depending on AZ. Default: SSD. Available options are:"
  #  SAS: high I/O disk type. Available for all AZs.
  #  SSD: ultra-high I/O disk type. Available for all AZs.
  #  GPSSD: the general purpose SSD type
  #  ESSD: extreme SSD disk type.
  default = "SSD"
}

variable "system_disk_size" {
  type        = number
  description = "(Optional, Integer, ForceNew) The system disk size in GB, The value range is 1 to 1024. Changing this creates a new server."
  default     = 40
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default = {
    Automation = "Terraform"
  }
}

variable "os_scheduler_hints_vars" {
  type = list(object({
    group   = string
    tenancy = string
  }))
  default = []
}

variable "eip" {
  type        = string
  description = "Elastic IP (EIP)"
  default     = ""
}
