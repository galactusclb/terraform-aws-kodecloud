#!/bin/bash

SUBCKET_NAME=$s3_bucket
SECRET_NAME=$secret_name

# 1. Install Docker & Git
sudo dnf install -y docker git
sudo systemctl enable --now docker
sudo usermod -aG docker ec2-user

# 2. Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# 4. Create the .env file
cat <<EOF > .env
S3_BUCKET=$SUBCKET_NAME
AWS_SECRET_NAME=$SECRET_NAME
EOF

# 5. Run the application
sudo docker-compose up -d