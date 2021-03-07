module "asg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git/?ref=master"


  name            = "mc-dev-asg"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = [var.web_sg_id]
  user_data       = templatefile("${path.module}/userdata.sh", { efs_id = var.efs_id, password = var.password })

  root_block_device = [
    {
      volume_size           = "50"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  vpc_zone_identifier       = var.subnet_webservers
  health_check_type         = "ELB"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_grace_period = 60
  target_group_arns         = module.alb.target_group_arns
  enabled_metrics           = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]

  tags_as_map = {
    Server      = "WebServer"
    Environment = "dev"
  }
}