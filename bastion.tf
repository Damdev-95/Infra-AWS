resource "aws_instance" "bastionr" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.keypair
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = var.disk_size
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = format("%s-Bastion-Host", var.name)
  }
}