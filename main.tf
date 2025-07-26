resource "aws_vpc" "myvpc" {
  cidr_block = var.vpccidr
  tags = {
    Name = "Terraform vpc"
  }
}

resource "aws_subnet" "mysubnet1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub1_cidr
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Terraform sub1"
  }
}

resource "aws_subnet" "mysubnet2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.sub2_cidr
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Terraform sub2"
  }
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "Terraform IGW"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "Terraform Route table"
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.mysubnet1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.mysubnet2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "mywebsg" {
    vpc_id      = aws_vpc.myvpc.id
    tags = {
    Name = "Terraform SG"
  }
  ingress {
    description = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP hosting"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "i1" {
    ami = var.ami
    instance_type = var.instancetype
    vpc_security_group_ids = [aws_security_group.mywebsg.id]
    subnet_id = aws_subnet.mysubnet1.id
    user_data = base64encode(file("userdata.sh"))
    key_name = "scoupss"
    tags = {
      Name="Terraform i1"
    }
}
resource "aws_instance" "i2" {
    ami = var.ami
    instance_type = var.instancetype
    vpc_security_group_ids = [aws_security_group.mywebsg.id]
    subnet_id = aws_subnet.mysubnet2.id
    user_data = base64encode(file("userdata.sh"))
        key_name = "scoupss"
    tags = {
      Name="Terraform i2"
    }
}

