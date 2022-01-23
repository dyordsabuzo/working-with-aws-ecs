data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon", "self"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}




data "template_file" "userdata" {
  template = file("./template/userdata.tpl")

  vars = {
    nginx_conf   = data.template_file.nginx_conf.rendered
    cluster_name = var.cluster_name
  }
}


data "template_file" "nginx_conf" {
  template = file("./template/server-conf.tpl")

  vars = {
    nginx_port = var.nginx_port
  }
}
