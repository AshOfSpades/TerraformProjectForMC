module "lb_sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git/?ref=master"

  name        = "mc-loadbalancer-sg"
  description = "Security group for loadbalancer with HTTP ports open publicly"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.lb_ingress
  ingress_rules       = ["http-80-tcp"]

  computed_egress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.webserver_sg.this_security_group_id
    }
  ]
  number_of_computed_egress_with_source_security_group_id = 1
}

module "webserver_sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git/?ref=v3.18.0"

  name        = "mc-webserver-sg"
  description = "Security group for webservers with access to yum repos"
  vpc_id      = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.lb_sg.this_security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.jumpbox_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  computed_egress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.efs1-sg.this_security_group_id
    },
    {
      rule                     = "all-all"
      source_security_group_id = module.efs2-sg.this_security_group_id
    },
    {
      rule                     = "all-all"
      source_security_group_id = module.efs3-sg.this_security_group_id
    }
  ]
  number_of_computed_egress_with_source_security_group_id = 3
}

module "jumpbox_sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git/?ref=master"

  name        = "mc-jumpbox-sg"
  description = "Security group for jumpbox with SSH ports open to webservers"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.lb_ingress
  ingress_rules       = ["ssh-tcp"]

  computed_egress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.webserver_sg.this_security_group_id
    }
  ]
  number_of_computed_egress_with_source_security_group_id = 1
}

module "efs1-sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git/?ref=v3.18.0"

  name        = "mc-efs-mount1-sg"
  description = "Security group for efs mount target"
  vpc_id      = var.vpc_id
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.webserver_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

module "efs2-sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git/?ref=v3.18.0"

  name        = "mc-efs-mount2-sg"
  description = "Security group for efs mount target"
  vpc_id      = var.vpc_id
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.webserver_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

module "efs3-sg" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git/?ref=v3.18.0"

  name        = "mc-efs-mount3-sg"
  description = "Security group for efs mount target"
  vpc_id      = var.vpc_id
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.webserver_sg.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}


output "lb_sg_id" {
  value = module.lb_sg.this_security_group_id
}

output "webserver_sg_id" {
  value = module.webserver_sg.this_security_group_id
}

output "jumpbox-sg" {
  value = module.jumpbox_sg.this_security_group_id
}

output "efs_mount_1-sg" {
  value = module.efs1-sg.this_security_group_id
}

output "efs_mount_2-sg" {
  value = module.efs2-sg.this_security_group_id
}

output "efs_mount_3-sg" {
  value = module.efs3-sg.this_security_group_id
}