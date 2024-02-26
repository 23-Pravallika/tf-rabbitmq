## Creates Security Group 
resource "aws_security_group" "allow_rabbitmq" {
 name        = "roboshop-rabbit-${var.ENV}-sg"
 description = "Allows only internal traffic"
 vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID
 
ingress {
   description = "Allows Only App Port"
   from_port   = var.RABBITMQ_PORT
   to_port     = var.RABBITMQ_PORT
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
 }

ingress {
   description = "Allows Only SSH on Internal Network"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

tags = {
    Name = "roboshop-rabbitmq-${var.ENV}-sg"
  }
}



