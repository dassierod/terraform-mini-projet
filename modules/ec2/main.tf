terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_ami" "bionic" {
  owners             = ["099720109477"]
  most_recent        = true
  include_deprecated = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.bionic.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  user_data                   = file("${path.module}/install-nginx.sh")
  user_data_replace_on_change = true
  tags = {
    Name = var.instance_name
  }
}

resource "aws_volume_attachment" "data" {
  device_name = "/dev/sdf"
  volume_id   = var.volume_id
  instance_id = aws_instance.web.id
}

resource "aws_eip_association" "web" {
  allocation_id        = var.eip_allocation_id
  network_interface_id = aws_instance.web.primary_network_interface_id
}

resource "terraform_data" "nginx_ready" {
  triggers_replace = [
    aws_instance.web.id,
    aws_eip_association.web.id,
    var.public_ip
  ]

  depends_on = [
    aws_eip_association.web,
    aws_volume_attachment.data
  ]

  provisioner "local-exec" {
    working_dir = path.root

    environment = {
      PUBLIC_IP = var.public_ip
    }

    command = <<-EOT
      set -eu
      curl --fail --silent --show-error --noproxy '*' \
        --retry 36 --retry-all-errors --retry-delay 10 \
        --connect-timeout 3 --max-time 5 --output /dev/null \
        "http://$PUBLIC_IP/"
      printf '%s\n' "$PUBLIC_IP" > ip_ec2.txt
    EOT
  }
}