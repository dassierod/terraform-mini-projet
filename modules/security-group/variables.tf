variable "vpc_id" {
  description = "Identifiant du VPC dans lequel créer le groupe de sécurité."
  type        = string
}

variable "web_ipv4_cidr" {
  description = "Plage IPv4 autorisée à joindre le serveur Web."
  type        = string
}