module "security_group" {
  source = "../modules/security-group"

  vpc_id        = aws_vpc.lab.id
  web_ipv4_cidr = "0.0.0.0/0"
}

module "ebs" {
  source = "../modules/ebs"

  availability_zone = aws_subnet.public.availability_zone
  size_gib          = 20
}

module "eip" {
  source = "../modules/eip"

  depends_on = [aws_route_table_association.public]
}

module "ec2" {
  source = "../modules/ec2"

  instance_type     = "t3.micro"
  instance_name     = "nginx-rodrigue"
  subnet_id         = aws_subnet.public.id
  security_group_id = module.security_group.security_group_id
  volume_id         = module.ebs.volume_id
  eip_allocation_id = module.eip.allocation_id
  public_ip         = module.eip.public_ip
}