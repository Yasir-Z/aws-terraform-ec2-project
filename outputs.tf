output "instance_public_ip" {
    value = aws_instance.my_instance.public_ip
}

output "ssh_command" {
value = "ssh -i ~/.ssh/demo-terraform-key.pem ubuntu@${aws_instance.my_instance.public_ip}"
}
