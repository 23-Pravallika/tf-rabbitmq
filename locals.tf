locals {
    SSH_USERNAME = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USR"]
    SSH_PASSWORD = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASS"]
}


