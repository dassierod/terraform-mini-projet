output "instance_id" {
  description = "Identifiant de l’instance EC2."
  value       = aws_instance.web.id
}