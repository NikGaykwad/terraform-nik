
# Output for count
/*
output "instance_public_ip" {
  value       = aws_instance.my_instance[*].public_ip
  description = "Public IP of the EC2 instance"
}

output "instance_name" {
  value       = aws_instance.my_instance[*].tags["Name"]
  description = "Name tag of the EC2 instance"
}

output "instance_public_dns" {
  value       = aws_instance.my_instance[*].public_dns
  description = "DNS tag of the EC2 instance"
}
*/

# Output for for-each loop
output "instance_public_ip" {
  value = [
    for instance in aws_instance.my_instance : instance.public_ip
  ]
}

output "instance_public_dns" {
  value = [
    for instance in aws_instance.my_instance : instance.public_dns
  ]
}