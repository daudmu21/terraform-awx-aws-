resource "aws_route53_record" "tower" {
  zone_id = "${var.zone_id}"
  name    = "tower.${var.domain}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.awx.public_ip}"]
}
