module "alb" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git/?ref=master"

  name = "mc-dev-lb"

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  subnets         = var.subnet_loadbalancer
  security_groups = [var.lb_sg_id]

  target_groups = [
    {
      name_prefix      = "mc-tg"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      health_check = {
        enabled             = true
        interval            = 60
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 6
        timeout             = 50
        protocol            = "HTTP"
        matcher             = "200-399"
      }

    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Name        = "mc-load-balancer"
    Environment = "dev"
  }
}

output "alb_dns" {
  value = module.alb.this_lb_dns_name
}