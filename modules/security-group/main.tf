terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  web_ports = {
    http  = 80
    https = 443
  }
}

resource "aws_security_group" "web" {
  name_prefix = "mini-projet-web-"
  description = "Acces Web pour le serveur Nginx"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "web" {
  for_each = local.web_ports

  security_group_id = aws_security_group.web.id
  cidr_ipv4         = var.web_ipv4_cidr
  ip_protocol       = "tcp"
  from_port         = each.value
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "web" {
  for_each = local.web_ports

  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = each.value
  to_port           = each.value
}