output "access_your_app" {
  value = "http://${aws_instance.name.public_ip}:8096"
}
