output "allocation_id" {
  description = "Identifiant AWS de l’Elastic IP à associer à l’EC2."
  value       = aws_eip.web.id
}

output "public_ip" {
  description = "Adresse IPv4 publique du serveur Web."
  value       = aws_eip.web.public_ip
}