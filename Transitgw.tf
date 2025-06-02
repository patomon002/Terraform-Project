# resource "aws_ec2_transit_gateway" "main-tgw" {
#   description                     = "Transit Gateway for 2 VPCs"

#   tags                            = {
#     Name                          = "Transitgw"
#   }
# }

# #VPC Attachment

# resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_Bastion-VPC" {
#   subnet_ids       = ["${aws_subnet.bastion_public_subnet.id}", "${aws_subnet.bastion_public_subnet2.id}"]
#   transit_gateway_id = aws_ec2_transit_gateway.main-tgw.id
#   vpc_id             = "${aws_vpc.bastion_vpc.id}"
#   tags               = {
#     Name             = "tgw-att-bastion_vpc"
   
#   }

# }

# resource "aws_ec2_transit_gateway_vpc_attachment" "main_vpc1" {
#   subnet_ids         = ["${aws_subnet.main_public_subnet1.id}", "${aws_subnet.main_public_subnet2.id}"]
#   transit_gateway_id = aws_ec2_transit_gateway.main-tgw.id
#   vpc_id             = "${aws_vpc.main_vpc.id}"
#   tags               = {
#     Name             = "tgw-att-vpc_main"

#   }
  
# }

