resource "aws_key_pair" "my_key" {
    key_name = "terra-key-ec2"
    public_key = file("terra-key-ec2.pub")

}

resource "aws_default_vpc" "default" {
    tags = {
        Name = "Default VPC"
    }
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
}




resource "aws_security_group" "my_security_group" {
    name = "automate-sg"
    description = "this will add a TF generated Security group"
    vpc_id = aws_default_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "all access open outbound"
    }
    tags = {
        Name = "automate-sg"
    }
}

resource "aws_instance" "my_instance" {
    for_each = tomap({
      TWS-Junoon-automate-micro1 = "t2.micro"
})
    depends_on = [ aws_security_group.my_security_group, aws_key_pair.my_key ]
    ami                    = data.aws_ami.ubuntu.id
    instance_type          = each.value
    key_name                = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    associate_public_ip_address = true

    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y nginx
        systemctl start nginx
        systemctl enable nginx
        echo "<h1>Welcome to TWS E-commerce App!</h1>" > /usr/share/nginx/html/index.html
    EOF
    root_block_device {
      volume_size = var.env == "prd" ? 10 : var.ec2_default_root_storage_size
        volume_type = "gp3"
    }
    tags = {
        Name = each.key
        Environment = var.env
      }
}
