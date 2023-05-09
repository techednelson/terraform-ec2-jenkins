resource "aws_instance" "ec2" {
  ami                         = "ami-03aefa83246f44ef2"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups_ids
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated.key_name
  user_data                   = file("${path.module}/ec2-user-data.sh")

  connection {
    user        = "ec2-user"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "chmod 600 ${local_file.private_key_pem.filename}"
  }

  tags = {
    Name = "${var.name}-ec2"
  }
}