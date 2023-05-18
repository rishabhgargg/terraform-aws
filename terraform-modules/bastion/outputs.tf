output "ami_name" {
  value = data.aws_ami.fetch_ami.id
}