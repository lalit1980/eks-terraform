output "lb_dns_name" {
  value = aws_lb.app.dns_name
}
output "lb_dns_zone_id" {
  value = aws_lb.app.zone_id
}