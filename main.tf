provider "aws" {
  region = "us-east-1"
}

# This opens the firewall for Port 8000 so your curl command actually works
resource "aws_security_group" "app_sg" {
  name        = "brain-tumor-sg"
  description = "Allow web traffic to app"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows you to curl from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "brain_tumor_app" {
  ami           = "ami-0c7217cdde317cfec" # Double check this is an Ubuntu AMI in your region
  instance_type = "t2.micro"
  
  # Connects the firewall to this server
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "BrainTumorApp"
  }

  # Notice the "-p 8000:8000" added to forward the traffic into Docker
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install docker.io -y
              sudo systemctl start docker
              sudo docker run -d -p 8000:8000 rayyanmustafa/brain-tumor:latest
              EOF
}

output "instance_public_ip" {
  value = aws_instance.brain_tumor_app.public_ip
}