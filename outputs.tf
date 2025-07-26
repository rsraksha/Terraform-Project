output "vpc_id" {
  value = aws_vpc.myvpc.id
}
output "subnet1" {
  value = aws_subnet.mysubnet1.id
}
output "subnet2" {
  value = aws_subnet.mysubnet2.id
}
output "routetable" {
  value = aws_route_table.RT.id
}
output "igw" {
  value = aws_internet_gateway.myigw.id
}
output "publicip1" {
  value = aws_instance.i1.public_ip
}
output "publicip2" {
  value = aws_instance.i2.public_ip
}