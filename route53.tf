resource "aws_route53_record" "komiser" {
  zone_id = var.hosted_zone_id
  name    = "demo.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_elb.komiser_elb.dns_name
    zone_id                = aws_elb.komiser_elb.zone_id
    evaluate_target_health = true
  }
}