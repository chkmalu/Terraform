#!/bin/sh
sudo yum upgrade -y && sudo yum install docker -y
sudo systemctl start docker.service
sudo usermod -aG docker ec2-user 
docker run -d -p 8080:80 --name nginx nginx