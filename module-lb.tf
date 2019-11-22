module "lb" {
  source = "./modules/lb"

  vpc_id     = "${var.vpc_id}"
  install_id = "${module.common.install_id}"

  prefix = "${var.prefix}"
  project_name = "${var.project_name}"
  domain = "${var.domain}"

  public_subnets              = "${var.public_subnets}"
  public_subnets_cidr_blocks  = "${var.public_subnets_cidr_blocks}"
  private_subnets_cidr_blocks = "${var.private_subnets_cidr_blocks}"

  hostname       = "${var.hostname}"
  update_route53 = "${var.update_route53}"

  cert_domain = "${var.cert_domain}"
  create_cert = "${var.create_cert}"
}
