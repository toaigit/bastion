provider "aws" {
  region = "${var.region}"
}

resource "aws_autoscaling_group" "ServerGroup" {
  name                      = "${var.autoscaling_group_name}"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  desired_capacity          = "${var.asg_desired}"
  health_check_grace_period = "${var.health_check_grace_period}"
  vpc_zone_identifier       = ["${var.subnet1}","${var.subnet2}","${var.subnet3}"]
  launch_configuration      = "${aws_launch_configuration.LaunchConfig.name}"

  tag {
    key = "Name"
    value = "${var.host_name}"
    propagate_at_launch = true    
  }
}

resource "aws_launch_configuration" "LaunchConfig" {
  name                        = "${var.launch_config_name}"
  image_id                    = "${var.image_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  security_groups             = ["${var.bastionsg}"]
  iam_instance_profile        = "${var.iamrole}"
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }

user_data = <<EOF
#cloud-config
runcmd:
- /bin/timedatectl set-timezone America/Los_Angeles
- mkdir /efs/share ; chmod 700 /efs/share
- /bin/domainname "${var.localdomain_name}"  
- /bin/hostname "${var.host_name}"
- /root/.local/bin/aws s3 cp s3://yourbucket.domain.name/ec2config.tar.gz /efs/share
- tar -xzvf /efs/share/ec2config.tar.gz -C /efs/share
- /bin/rm /efs/share/ec2config.tar
- /bin/cp -p /efs/share/etc/krb5.conf /etc
- /bin/cp -p /efs/share/etc/duo/pam_duo.conf /etc/duo
- /bin/cp -p /efs/share/etc/ssh/sshd_config /etc/ssh
- /bin/cp -p /efs/share/etc/pam.d/sshd /etc/pam.d
- /bin/cp -p /efs/share/etc/pam.d/system-auth-ac /etc/pam.d
- echo PS1=\"[\\\\u@${var.host_name}]\" >> /etc/bashrc
- /root/.local/bin/aws ec2 associate-address --instance-id $(curl http://169.254.169.254/latest/meta-data/instance-id) --allocation-id "${var.eip}" --allow-reassociation --region us-west-2
- systemctl restart sshd
EOF
}
