output "security_group_id" {
  description = "Identifiant du groupe de sécurité à transmettre au module EC2."
  value       = aws_security_group.web.id
}