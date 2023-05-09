resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "local_file" "private_key_pem" {
  filename = "ec2Key.pem"
  content  = tls_private_key.generated.private_key_pem
}

resource "aws_key_pair" "generated" {
  key_name   = "ec2Key"
  public_key = tls_private_key.generated.public_key_openssh

  lifecycle {
    ignore_changes = [key_name]
  }
}