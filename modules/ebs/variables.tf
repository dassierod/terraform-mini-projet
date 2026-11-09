variable "availability_zone" {
  description = "Zone de disponibilité du volume EBS."
  type        = string
}

variable "size_gib" {
  description = "Taille du volume EBS en Gio."
  type        = number
}