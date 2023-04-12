resource "aws_instance" "komiser" {
  ami           = "ami-0fa03365cde71e0ab"
  instance_type = var.instance_type
  key_name = var.key
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.komiser_sg.id]
  iam_instance_profile = aws_iam_instance_profile.komiser_instance_profile.name
  //user_data = file("scripts/install.sh")

  tags = {
    Name = "komiser"
    Owner = var.owner
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.private_key_path)
    host = self.public_ip
  } 

  provisioner "file" {
    source      = "scripts/config.toml"
    destination = "/home/ec2-user/config.toml"
  }

  provisioner "file" {
    source      = "scripts/docker-compose.yml"
    destination = "/home/ec2-user/docker-compose.yml"
  }

  provisioner "file" {
    source      = "scripts/install.sh"
    destination = "/tmp/install.sh"
  }

  provisioner "remote-exec" {
    inline = ["bash /tmp/install.sh", "sudo docker-compose -f /home/ec2-user/docker-compose.yml up -d"]
  }
}

resource "aws_security_group" "komiser_sg" {
  name        = "komiser_sg"
  description = "Allow traffic on port 3000 and enable SSH"

  ingress {
    from_port       = "22"
    to_port         = "22"
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = "3000"
    to_port         = "3000"
    protocol        = "tcp"
    security_groups = [aws_security_group.komiser_elb_sg.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "komiser_sg"
    Owner = var.owner
  }
}