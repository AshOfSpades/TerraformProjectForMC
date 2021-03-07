module "jumpbox" {
  source         = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git/?ref=master"
  name           = "mc-jumpbox"
  instance_count = 1

  ami                    = var.ami_id
  instance_type          = var.instance_type
  monitoring             = true
  vpc_security_group_ids = [var.jumpbox_sg]
  subnet_id              = var.jumpbox_subnet
  user_data              = templatefile("${path.module}/jumpbox-userdata.sh", { password = var.password })

  tags = {
    Server      = "JumpBox"
    Environment = "dev"
  }
}

output "jumpbox_ip" {
  value = module.jumpbox.public_ip
}