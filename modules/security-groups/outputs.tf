output "ec2_ssh_sg" {
  value = aws_security_group.ec2_ssh_sg
}

output "ec2_web_sg" {
  value = aws_security_group.ec2_web_sg
}