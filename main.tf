# #Script to deploy ec2 into a subnet, within a VPC and network interface

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.39.0"
    }
  }
}
 
provider "aws" {
  # Configuration options
  region = "us-east-1"
}

#VPCs Resources

# resource "aws_vpc" "bastion_vpc" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_hostnames = "true"
#   tags = {
#     Name = "Bastion"
#   }
     
# }

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    Name = "main"
  }  
     
}

#Internet Gateways

# resource "aws_internet_gateway" "bastion_gw" {
#   vpc_id = aws_vpc.bastion_vpc.id

#   tags = {
#     Name = "main"
#   }
# }

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main"
  }
}

#NAT Gateway

# resource "aws_nat_gateway" "main_nat_gw" {
#   subnet_id     = aws_subnet.main_public_subnet1.id
#   allocation_id = aws_eip.main.id
#   tags = {
#     Name = "gw NAT"
#   }

#   depends_on = [aws_internet_gateway.main_gw]

# }


#Route Tables 

# resource "aws_route_table" "Bastion_vpc" {
#   vpc_id = aws_vpc.bastion_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.bastion_gw.id
#   }

#   tags = {
#     Name = "Bastion route stable"
#   }
# }

resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  tags = {
    Name = "main_vpc_public_subnet"
  }
}

# resource "aws_route_table" "private_subnet" {
#   vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.main_nat_gw.id
#   }

#   tags = {
#     Name = "main_vpc_private_subnet"
#   }
# }

#Route Table Association

# resource "aws_route_table_association" "bastion" {
#   subnet_id      = aws_subnet.bastion_public_subnet.id
#   route_table_id = aws_route_table.Bastion_vpc.id
# }

# resource "aws_route_table_association" "bastion2" {
#   subnet_id      = aws_subnet.bastion_public_subnet2.id
#   route_table_id = aws_route_table.Bastion_vpc.id
# }

resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.main_public_subnet1.id
  route_table_id = aws_route_table.public_subnet.id
}

# resource "aws_route_table_association" "public_subnet2" {
#   subnet_id      = aws_subnet.main_public_subnet2.id
#   route_table_id = aws_route_table.public_subnet.id
# }

# resource "aws_route_table_association" "private_subnet1" {
#   subnet_id      =  aws_subnet.main_private_subnet1.id
#   route_table_id = aws_route_table.private_subnet.id
# }

# resource "aws_route_table_association" "private_subnet2" {
#   subnet_id      = aws_subnet.main_private_subnet2.id
#   route_table_id = aws_route_table.private_subnet.id
# }


#Subnets

# resource "aws_subnet" "bastion_public_subnet" {
#   vpc_id            = aws_vpc.bastion_vpc.id 
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = "us-east-1a"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "Bastion_public_subnet"
#   }
 

# }

# resource "aws_subnet" "bastion_public_subnet2" {
#   vpc_id            = aws_vpc.bastion_vpc.id 
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "us-east-1b"
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "Bastion_public_subnet2"
#   }
 

# }

resource "aws_subnet" "main_public_subnet1" {
  vpc_id            = aws_vpc.main_vpc.id 
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-east-1a"
 map_public_ip_on_launch = true
 tags = {

  Name = "main_public_subnet1"
 }

}

# resource "aws_subnet" "main_public_subnet2" {
#   vpc_id            = aws_vpc.main_vpc.id 
#   cidr_block        = "10.1.2.0/24"
#   availability_zone = "us-east-1b"
#  map_public_ip_on_launch = true
#  tags = {
#   Name = "public_subnet2"
#  }

# }

# resource "aws_subnet" "main_private_subnet1" {
#   vpc_id            = aws_vpc.main_vpc.id 
#   cidr_block        = "10.1.3.0/24"
#   availability_zone = "us-east-1a"
#   tags = {
#     Name = "private_subnet1"
#   }
 

# }

# resource "aws_subnet" "main_private_subnet2" {
#   vpc_id            = aws_vpc.main_vpc.id 
#   cidr_block        = "10.1.4.0/24" 
#   availability_zone = "us-east-1b"
#   tags = {
#     Name = "private_subnet2"
#   }
 
# }

 
#Security groups

# resource "aws_security_group" "bastion_vpc" {
#  name        = "permission for VPC"
#   description = "Allow TLS inbound traffic and all outbound traffic"
#   vpc_id      = aws_vpc.bastion_vpc.id
#   ingress {
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port        = 80
#     to_port          = 80 
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]

#   }

#    ingress {
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#    }

#     ingress {
#     from_port        = 8080
#     to_port          = 8080
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"] 
    
#   }

#    egress {
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#    egress {
#     from_port        = 8080
#     to_port          = 8080
#     protocol         = "UDP"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#  egress {
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }


# }


resource "aws_security_group" "main_vpc" {
 name        = "permission for VPC"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 8443
    to_port          = 8443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    from_port        = 80
    to_port          = 80 
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

   ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }

    ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
    
  }

  ingress {
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
    
  }

    ingress {
    from_port        = 8082
    to_port          = 8082
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
    
  }

    ingress {
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

    ingress {
    from_port        = 2375
    to_port          = 2375
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

   egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    egress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 egress {
    from_port        = 8443
    to_port          = 8443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    egress {
    from_port        = 2375
    to_port          = 2375
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 587
    to_port          = 587
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 465
    to_port          = 465
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}


#Elastic IPs

# resource "aws_eip" "bastion" {
#   domain                    = "vpc"
#   depends_on                = [aws_internet_gateway.bastion_gw]
# }

# resource "aws_eip" "main" {
#   domain                    = "vpc"
#   depends_on                = [aws_internet_gateway.main_gw]
# }

# resource "aws_eip" "tomcat" {
#   domain                    = "vpc"
#   network_interface = aws_network_interface.tomcat.id
# }



#Keys

resource "aws_key_pair" "macbook" {    #macbook
  key_name   = "macbook"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtkg8hrJLXyOazDPrVdOqxmzHzSDwcN1oOhbzXWm0ljWAY1FCGzyQX8cbsFJUAPejAaa8LJjov2FIFioh/cOTG1Vdk+M5Sc7lMg+AKJuUvANHpnGICToDpwokcwsZv4EwAISU/zCyVHloDi+4/tDgPwLr485jhCyxjgFjtiXqdrwKv2BvYnN6c0D2TZgkDIqGEFqKse1Y6i+i7QvcDjeN/IBm55ewwDSFtu1roIZBaHjFM1uR8/KjZq9/54M8TZ5b6EI5saik4wHZaKPTU/Y/5ko/8Z3xHyitBqvL8M/p2DN4ySDGeV7TrKrwUfuijHo0eH+9yLgsNQNXvzDIaKFduzIxn9MwOmBKCIf9Jq0xyw5FTt1iMPtTfRCaLAqKco0i6iFHqambU5YERcl8MoTYMsPbHhPvCXh+jmefsUecPSvM6dYkNLoEpamLaSRungQKRozTu+BXFu9rIJj0qCAUvhWDLHPJeGgKLu/PxR3rjL1u4NnlF/Lql79g4IvdxzAE= patrickomorovan@Patricks-MacBook-Pro.local"
}

# resource "aws_key_pair" "office" {     #officelaptop
#   key_name   = "office"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOljUMVeoE4DnxOiZwyECc19obQsYT0MJideH4U/I8cyvbHMiAx5QC9cavh7ak9DpEwogjKICXCBnljbHLm6/2xOiWkswZbVgUMn9ATbXbZhgestNcoAdY4LJwpF0T8QewYIuC2oHnCc3MHfK9KFjqSF8HDxv7tW6I/550rYChKj423uRBRm9sqbWKAzfvh+qQ1IHefQZ9vw7ilx9LVmW+RLaJLWxVvJhPUssB9DVXXqTVo8TkP8qtkjaKL2swXbbstCO6P1cnzGXbM/Nhmp1J7fiFIgvFjjA3HiiF+BUTEeNIZoyeaaAFcLMxeSevDQ99Dhad0UyJ4q2b7nO/VMefipEJ2MKdF7BBb6mjqSuSviw2UCY4Bu+M9bjZx2JPqEYI4uzsh/zCnEmgGX73WrHf9IOniPXdohiI1KLREsPaYJMoO9PckcipJPR4ZRJJUsCZECVDdpIYwyUkq0gwYLHcbqdBjbbKwF3koiZvWe/myq5eI3AWChmYV3yUYE49D6k= patri@DESKTOP-C1I06IV"
# }



#Network Interface

# resource "aws_network_interface" "bastion" {
#   subnet_id   = aws_subnet.bastion_public_subnet.id
#   security_groups = [aws_security_group.bastion_vpc.id]

#   tags = {
#     name = "bastion_network_interface"
#   }
# }

# resource "aws_network_interface" "main_vpc" {
#   subnet_id   = aws_subnet.main_public_subnet1.id
#   security_groups = [aws_security_group.main_vpc.id]
  
#   tags = {
#     name = "nginx_network_interface"
#   }
# }

# resource "aws_network_interface" "main_vpc" {
#   subnet_id   = aws_subnet.main_private_subnet1.id
#   security_groups = [aws_security_group.main_vpc.id]

#   tags = {
#     name = "Tomcat_network_interface"
#   }
# }


# resource "aws_network_interface" "maven" {
#   subnet_id   = aws_subnet.main_public_subnet1.id    #Place it in a public subnet so that I can access it
#   security_groups = [aws_security_group.main_vpc.id]

#   tags = {
#     name = "Maven_network_interface"
#   }
# }

# resource "aws_network_interface" "tomcat" {
#   subnet_id   = aws_subnet.main_public_subnet1.id
#   security_groups = [aws_security_group.main_vpc.id]
  
#   tags = {
#     name = "tomcat_network_interface"
#   }
# }

# resource "aws_network_interface" "jenkins" {
#   subnet_id   = aws_subnet.main_public_subnet1.id
#   security_groups = [aws_security_group.main_vpc.id]
  
#   tags = {
#     name = "jenkins_network_interface"
#   }
# }

resource "aws_network_interface" "docker" {
  subnet_id   = aws_subnet.main_public_subnet1.id
  security_groups = [aws_security_group.main_vpc.id]
  
  tags = {
    name = "docker_network_interface"
  }
}

resource "aws_network_interface" "K8" {
  subnet_id   = aws_subnet.main_public_subnet1.id
  security_groups = [aws_security_group.main_vpc.id]
  
  tags = {
    name = "k8_network_interface"
  }
}


#AWS EC2 Instance with user data and instance profile which attaches the IAM role
 
# resource "aws_instance" "Bastion" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.micro"
#   key_name = "office"
#   iam_instance_profile = "${aws_iam_instance_profile.EC2_profile.name}"
#   user_data = "${file("bastion.sh")}" 

#   network_interface {
#     network_interface_id = aws_network_interface.bastion.id
#     device_index         = 0
#   }

# tags = {

#   Name = "Bastion"
# }
              
# }



# resource "aws_instance" "Nginx" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.micro"
#   key_name = "macbook"
#   # iam_instance_profile = "${aws_iam_instance_profile.EC2_profile.name}"
#   user_data = "${file("nginx.sh")}" 

#   network_interface {
#     network_interface_id = aws_network_interface.main_vpc.id
#     device_index         = 0
#   }

# tags = {

#   Name = "Nginx"
# }
              
# }


# resource "aws_instance" "Tomcat" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.micro"
#   key_name = "macbook"
#   # iam_instance_profile = "${aws_iam_instance_profile.EC2_profile.name}"
#   user_data = "${file("tomcat.sh")}" 

#   network_interface {
#     network_interface_id = aws_network_interface.tomcat.id
#     device_index         = 0
#   }

# tags = {

#   Name = "Tomcat"
# }
              
# }

resource "aws_instance" "Docker" {
  ami           = "ami-080e1f13689e07408"
  instance_type = "t2.micro"
  key_name = "macbook"
  #iam_instance_profile = "${aws_iam_instance_profile.EC2_profile.name}"
  user_data = "${file("docker.sh")}" 

  network_interface {
    network_interface_id = aws_network_interface.docker.id
    device_index         = 0
  }

tags = {

  Name = "Docker"
}
              
}

# resource "aws_instance" "K8" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.medium"
#   key_name = "macbook"
#   #iam_instance_profile = "${aws_iam_instance_profile.EC2_profile.name}"
#   # user_data = "${file("K8.sh")}" 

#   network_interface {
#     network_interface_id = aws_network_interface.K8.id
#     device_index         = 0
#   }

# tags = {

#   Name = "K8"
# }
              
# }
# resource "aws_instance" "Jenkins" {
#   ami           = "ami-080e1f13689e07408"
#   instance_type = "t2.micro"
#   key_name = "macbook"
#   #iam_instance_profile = "${aws_iam_instance_profile.EC2_profile.name}"
#   user_data = "${file("jenkins.sh")}" 

#   network_interface {
#     network_interface_id = aws_network_interface.jenkins.id
#     device_index         = 0
#   }

# tags = {

#   Name = "Jenkins"
# }
              
# }

# resource "aws_instance" "Maven" {
#   ami           = "ami-0fe630eb857a6ec83"   #Redhat AMI
#   instance_type = "t2.micro"
#   key_name = "office"
#   user_data = "${file("maven.sh")}" 

#   network_interface {
#     network_interface_id = aws_network_interface.maven.id
#     device_index         = 0
#   }

# tags = {

#   Name = "Maven"
# }
              
# }


# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   db_name              = "mydb"
#   engine               = "mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.t2.micro"
#   username             = "test"
#   password             = "test"
#   parameter_group_name = "default.mysql8.0"
#   skip_final_snapshot  = true
# }



# Systems manager parameter creation -- This will store the custom metrics configuration

# resource "aws_ssm_parameter" "secret" {
#   name        = "/alarm/AWS-CWAgentLinConfig"
#   description = "Custom Metrics"
#   type        = "String"
#   value       = "${file("SSM_Parameter.json")}"

# }
