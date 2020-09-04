resource "aws_security_group" "sec_grp" {
  name        = "myagsec"
  description = "autoscalling security group"

  dynamic "ingress" {
    for_each = var.ports

    content {
      description = "myag sec grp"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    description = "myag sec grp"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysecgrp"
  }
}

