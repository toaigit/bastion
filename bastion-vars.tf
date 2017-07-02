variable "region" {
  default = "us-west-2"
  }

variable "autoscaling_group_name" {
  default = "ASG_Bastion_vpcUAT"
}

variable "launch_config_name" {
  default = "LC_Bastion_vpcUAT"
}

variable "iamrole" {
  default = "YourDefineRole"
}

variable "subnet1" {
  default = "subnet-c293d9dad"
}

variable "subnet2" {
  default = "subnet-d39dladfk"
}

variable "subnet3" {
  default = "subnet-29339399"
}

variable "min_size" {
  default = "1"
}

variable "max_size" {
  default = "1"
}

variable "asg_desired" {
  default = "1"
}

variable "health_check_grace_period" {
  default = "300"
}

variable "image_id" {
  default = "YOUR_AMI"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "your-keypair"
}

variable "bastionsg" {
  default = "sg-d58db8ae"
}

variable "dbsg" {
  default = "sg-0b83b670"
}

variable "websg" {
  default = "sg-768cb90d"
}

variable "elbsg" {
  default = "sg-ax86b3c4"
}

variable "efssg" {
  default = "sg-bd4sa3c3"
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "16"
}

variable "host_name" {
  default = "bastion"
  }

variable "localdomain_name" {
  default = "aws.domain.name"
  }

variable "eip" {
  default = "eipalloc-1224akdf"
  }

variable "delete_on_termination" {
  default = "true"
}
