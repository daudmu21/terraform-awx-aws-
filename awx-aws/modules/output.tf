output "domain" {
  value = " http://${aws_route53_record.tower.name}"
}
output "username"{
  value = "password: password"
}
output "password"{
  value = "username: admin"
}
output "To_Do"{
  value = "Please reset username and password"
}
