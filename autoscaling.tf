resource "aws_launch_configuration" "matt-launchconfig" {
  name_prefix     = "matt-launchconfig"
#  image_id        = var.AMIS[var.AWS_REGION]
  image_id        = data.aws_ami.latest-ubuntu.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mattkey.key_name
  security_groups = [aws_security_group.allow-scaling-group.id]
  user_data       = "#!/bin/bash\napt-get update\napt-get -y install nginx\nMYIP=`ifconfig | grep 'inet 10' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'this is: '$MYIP > /var/www/html/index.html"
}

resource "aws_autoscaling_group" "matt-autoscaling" {
  name                      = "matt-autoscaling"
  vpc_zone_identifier       = [aws_subnet.matt-pub-a.id, aws_subnet.matt-pub-b.id, aws_subnet.matt-pub-c.id]
  launch_configuration      = aws_launch_configuration.matt-launchconfig.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "ELB"  # if no elb then do "EC2"
  load_balancers            = ["${aws_elb.matt-elb.name}"]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "Matt autoscale instance"
    propagate_at_launch = true
  }
}

