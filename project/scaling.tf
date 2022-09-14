//--------------------------------------------------------------//
//                     LAUNCH TEMPLATE                          //
//--------------------------------------------------------------//

resource "aws_launch_template" "linux_public" {
  image_id               = local.linux_ami_id
  instance_type          = local.ec2_instance_type
  key_name               = aws_key_pair.aws_linux_public.key_name
  vpc_security_group_ids = [aws_security_group.web_access.id]
  user_data              = filebase64("./user-data-az-1.sh")

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "TF Linux Public ALB"
    }
  }
}

//--------------------------------------------------------------//
//                       TARGET GROUPS                          //
//--------------------------------------------------------------//

resource "aws_lb_target_group" "alb" {
  name     = "tf-tg-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.default_vpc_id

  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    matcher  = "200-299"
  }
}

resource "aws_lb_target_group" "alb0" {
  name     = "tf-tg-alb0"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.default_vpc_id

  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    matcher  = "200-299"
  }
}

/* resource "aws_lb_target_group_attachment" "linux_public" {
  target_group_arn = aws_lb_target_group.alb0.arn
  target_id        = aws_instance.aws_linux_public.id
} */

/* resource "aws_lb_target_group" "nlb" {
    name = "tf-tg-nlb"
    port = 80
    protocol = "TCP"
    vpc_id = local.default_vpc_id

    health_check {
        enabled = true
        protocol = "HTTP"
        path = ""
        matcher = "200-299"
    }
} */

//--------------------------------------------------------------//
//                        ELASTIC IPs                           //
//--------------------------------------------------------------//

/* resource "aws_eip" "one" {
    vpc = true
}

resource "aws_eip" "two" {
    vpc = true
}

resource "aws_eip" "three" {
    vpc = true
} */

//--------------------------------------------------------------//
//                       LOAD BALANCERS                         //
//--------------------------------------------------------------//

/* resource "aws_lb" "nlb" {
    name = "tf-nlb"
    internal = false
    load_balancer_type = "network"

    subnet_mapping {
        subnet_id = local.subnet_1a_id
        allocation_id = aws_eip.one.id
    }

    subnet_mapping {
        subnet_id = local.subnet_1b_id
        allocation_id = aws_eip.two.id
    }

    subnet_mapping {
        subnet_id = local.subnet_1c_id
        allocation_id = aws_eip.three.id
    }
} */

resource "aws_lb" "alb" {
  name               = "tf-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_access.id]
  subnets            = [local.subnet_1a_id, local.subnet_1b_id, local.subnet_1c_id]
}

//--------------------------------------------------------------//
//                    LOAD BALANCE LISTENER                     //
//--------------------------------------------------------------//

/* resource "aws_lb_listener" "nlb" {
    load_balancer_arn = aws_lb.nlb.arn
    port = 80
    protocol = "TCP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.nlb.arn
    }
} */

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}

resource "aws_lb_listener_rule" "app_group_a" {
  listener_arn = aws_lb_listener.alb.arn

  condition {
    query_string {
      key   = "AppGroup"
      value = "A"
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}

resource "aws_lb_listener_rule" "app_group_b" {
  listener_arn = aws_lb_listener.alb.arn

  condition {
    query_string {
      key   = "AppGroup"
      value = "B"
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb0.arn
  }
}

//--------------------------------------------------------------//
//                     AUTOSCALING GROUPS                       //
//--------------------------------------------------------------//

resource "aws_autoscaling_group" "linux_public" {
  name               = "TF ASG Linux Public"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  target_group_arns  = [aws_lb_target_group.alb.arn]
  desired_capacity   = 2
  min_size           = 2
  max_size           = 4

  launch_template {
    id      = aws_launch_template.linux_public.id
    version = "$Latest"
  }
}
