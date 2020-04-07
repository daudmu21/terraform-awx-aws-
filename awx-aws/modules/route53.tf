resource "aws_route53_record" "tower" {
  zone_id = "${var.zone_id}"
  name    = "tower.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.awx.public_ip}"]
}




resource "aws_route53_record" "worker1" {
  zone_id = "${var.zone_id}"
  name    = "worker1.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.worker1.public_ip}"]
}
resource "aws_route53_record" "worker2" {
  zone_id = "${var.zone_id}"
  name    = "worker2.${var.domain}"   
  type    = "A"
  ttl     = "60"
  records = ["${aws_instance.worker2.public_ip}"]
}
