output "volume_id" {
  description = "Identifiant du volume EBS à attacher à l’EC2."
  value       = aws_ebs_volume.data.id
}