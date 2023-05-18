data "aws_ami" "fetch_ami" {
  most_recent = true
  owners      = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-1.23-v20230127"]
    # amzn2-ami-hvm-2.0.20210303.0-x86_64-gp2
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "lt" {
  name = "LT-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.volume_size
    }
  }
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group]
  image_id               = data.aws_ami.fetch_ami.id
  tag_specifications {
    resource_type = "instance"
    tags = {
      Namespace   = "${lookup(var.tags, "Namespace")}"
      TG_Managed  = "${lookup(var.tags, "TG_Managed")}"
      Project     = "${lookup(var.tags, "Project")}"
      Name        = "-${lookup(var.tags, "Environment")}-${lookup(var.tags, "Name")}"
      Environment = "${lookup(var.tags, "Environment")}"
      Role        = "${lookup(var.tags, "Role")}"
      Cluster     = "${lookup(var.tags, "Cluster")}"
    }
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
  }
  user_data = base64encode(file("/terraform-modules/launch-template/userdata.sh"))
}