variable "instance_type" {
  description = "Type de l’instance EC2."
  type        = string
}

variable "instance_name" {
  description = "Valeur du tag Name de l’instance."
  type        = string
}

variable "subnet_id" {
  description = "Identifiant du sous-réseau de l’instance."
  type        = string
}

variable "security_group_id" {
  description = "Identifiant du groupe de sécurité Web."
  type        = string
}

variable "volume_id" {
  description = "Identifiant du volume EBS à attacher."
  type        = string
}

variable "eip_allocation_id" {
  description = "Identifiant d’allocation de l’Elastic IP."
  type        = string
}

variable "public_ip" {
  description = "Adresse IPv4 publique à tester et à enregistrer."
  type        = string
}