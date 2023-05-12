data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "komiser" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = var.key
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.komiser_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.komiser_instance_profile.name
  user_data = file("scripts/install.sh")

  tags = {
    Name  = "komiser"
    Owner = var.owner
  }
}

resource "aws_security_group" "komiser_sg" {
  name        = "komiser_sg"
  description = "Allow traffic on port 3000 and enable SSH"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // restrict with your CIDR or use a bastion host
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
    Name  = "komiser_sg"
    Owner = var.owner
  }
}
