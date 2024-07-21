locals {
  owner  = lower(var.Owner)
  projid = format("%s-%s", lower(var.vpc_name), lower(var.projid))

}

