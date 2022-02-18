resource "aws_autoscaling_group" "asg" {
  name                 = "wordpress-${terraform.workspace}"
  desired_capacity     = 2
  min_size             = 2
  max_size             = 3
  termination_policies = ["OldestInstance"]
  availability_zones   = data.aws_availability_zones.zones.names

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "template" {
  name                   = "wordpress-${terraform.workspace}"
  instance_type          = var.instance_type
  image_id               = data.aws_ami.ami.id
  ebs_optimized          = true
  vpc_security_group_ids = [aws_security_group.ec2_secgrp.id]

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.profile.arn
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name   = "wordpress-${terraform.workspace}"
      Source = "Autoscaling"
    }
  }

  user_data = base64encode(data.template_file.userdata.rendered)

}

resource "aws_security_group" "ec2_secgrp" {
  name        = "wordpress-instance-secgrp"
  description = "wordpress instance secgrp"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = var.nginx_port
    to_port     = var.nginx_port
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.default.cidr_block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-ec2-secgrp"
  }

}

resource "aws_default_vpc" "default" {
}

resource "aws_iam_instance_profile" "profile" {
  name = "wordpress-${terraform.workspace}"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name               = "wordpress-${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}
