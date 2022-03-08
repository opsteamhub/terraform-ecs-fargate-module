data "aws_acm_certificate" "issued" {
  domain      = var.cert_domain
  statuses    = ["ISSUED"]
  most_recent = true
}