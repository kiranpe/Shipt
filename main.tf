provider "aws" {
  region = "us-east-2"
  profile = "Terraform"
}

#########################
#EC2 Image
#########################

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20190722.1"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

############################
#Sec Grp && VPC
############################

data "aws_vpc" "select" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]
  }
}

###############################
#Security group and Access Key
###############################

module "sec_grp_access_key" {
 source = "./modules/common"
}

############################################
# Launch configuration and autoscaling group
############################################

module "launch_asg" {
  source = "./modules/autoscaling"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration

  lc_name = "my-lc"

  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  load_balancers  = [module.launch_elb.this_elb_id]

  ebs_block_device = [
    {
      device_name           = "/dev/sde"
      volume_type           = "gp2"
      volume_size           = "8"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "8"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "my-asg"
  vpc_zone_identifier       = ["subnet-07e0f3d0584242fee"]
  health_check_type         = "EC2"
  min_size                  = 1 
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  depends_on = [module.sec_grp_access_key]

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]
}

######
# ELB
######
module "launch_elb" {
  source = "./modules/elb"

  name = "elb-test"

  internal        = false
  subnet_ids         = ["subnet-07e0f3d0584242fee"]

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
 
  depends_on = [module.sec_grp_access_key]

  tags = {
   Name = "test-elb"
  }

}
