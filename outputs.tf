output "RABBITMQ_ENDPOINT"{
    value = aws_spot_instance_request.rabbitmq.private_ip
}

