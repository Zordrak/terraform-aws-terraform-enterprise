resource "aws_route53_record" "ptfe_lb" {
  count   = "${var.update_route53 ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${local.endpoint}"
  type    = "A"

  alias {
    name    = "${aws_lb.ptfe.dns_name}"
    zone_id = "${aws_lb.ptfe.zone_id}"

    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "cert" {
  count = "${var.create_cert ? 1 : 0}"
  domain_name       = "${local.hostname}.${var.domain}"
  validation_method = "DNS"
}

# This allows ACM to validate the new certificate
resource "aws_route53_record" "cert_validation" {
  count = "${var.create_cert ? 1 : 0}"
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

# This allows ACM to validate the new certificate
resource "aws_acm_certificate_validation" "cert" {
  count = "${var.create_cert ? 1 : 0}"
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}