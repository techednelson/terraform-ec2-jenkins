resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2.id
  vpc      = true
}

resource "aws_instance" "ec2" {
  ami                         = "ami-03aefa83246f44ef2" # AmazonLinux 2023
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups_ids
  associate_public_ip_address = true
  key_name                    = aws_key_pair.generated.key_name
  user_data                   = file("${path.module}/ec2-user-data.sh")

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
    timeout     = "2m"
  }

  provisioner "local-exec" {
    command = "chmod 600 ${local_file.private_key_pem.filename}"
  }

  provisioner "file" {
    source      = "${path.module}/plugins-installer.sh"
    destination = "/tmp/plugins-installer.sh"
  }

  provisioner "file" {
    source      = "${path.module}/plugins.txt"
    destination = "/tmp/plugins.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/plugins.txt .",
      "sudo mv /tmp/plugins-installer.sh ."
    ]
  }

  tags = {
    Name        = "${var.name}-ec2"
    Terraform   = "true"
    Environment = "dev"
  }
}