sudo amazon-linux-extras enable nginx1 && sudo yum clean metadata && sudo yum -y install nginx && nginx -v && sudo systemctl start nginx && sudo systemctl enable nginx
