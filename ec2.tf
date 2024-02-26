# Creates SPOT Servers
resource "aws_spot_instance_request" "rabbitmq" {
  ami           = data.aws_ami.my_ami.id
  instance_type = t2.micro
  wait_for_fulfillment = true
  vpc_security_group_ids = [aws_security_group.allow_rabbitmq.id]
  subnet_id = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID[0]
  iam_instance_profile = "practice-admin"
  
  tags = {
    Name = "rabbitmq-${var.ENV}"
  }
}

## Installing RabbitMQ
resource "null_resource" "db-rabbitmq" {
  
   provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = local.SSH_USERNAME
      password = local.SSH_PASSWORD
      host     = aws_spot_instance_request.rabbitmq.private_ip
      }

      inline = [
          "ansible-pull -U https://github.com/23-Pravallika/Ansible.git -e COMPONENT=rabbitmq -e ENV=dev robo-pull.yml"
        ]
    }
}



