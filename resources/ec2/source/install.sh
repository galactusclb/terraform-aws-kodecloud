#!/bin/bash

BUCKET_NAME=${var_s3_bucket}
SECRET_NAME=${var_secret_name}
DOCKER_COMPOSE_CONTENT=$var_docker_compose_content

# Install Docker & Git
dnf install -y docker git
systemctl enable --now docker
usermod -aG docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

cat <<EOF > docker-compose.yml
$DOCKER_COMPOSE_CONTENT
EOF

cat <<EOF > .env
S3_BUCKET=$BUCKET_NAME
AWS_SECRET_NAME=$SECRET_NAME
EOF

docker-compose up -d