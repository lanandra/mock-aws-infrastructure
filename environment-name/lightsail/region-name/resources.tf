######################
# Lightsail Instance #
######################

resource "aws_lightsail_instance" "my_instance" {
  name              = "my-instance"
  availability_zone = var.az[0]
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "micro_2_0"
  key_pair_name     = var.key_pair_name

  tags = {
    "Name"           = "my-instance"
    "my:environment" = "my-environment"
    "my:owner"       = "my-owner"
  }
}

resource "aws_lightsail_instance_public_ports" "my_instance_ports" {
  instance_name = aws_lightsail_instance.my_instance.name

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }
}
