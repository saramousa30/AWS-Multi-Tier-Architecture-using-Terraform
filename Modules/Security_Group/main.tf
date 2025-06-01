# ----------------------------------------------------------------------------- #
# -------------------------------- SG Module ---------------------------------- #
# ----------------------------------------------------------------------------- #


resource "aws_security_group" "alb_sg" {
  name        = "ALB_SG"
  description = "enable http/https access on port 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "ALB_SG"
    Owner = "Sara_Mousa"
  }
}

# create security group for the web
resource "aws_security_group" "web_sg" {
  name        = "Web_SG"
  description = "enable http/https access on port 80 for elb sg"
  vpc_id      = var.vpc_id

  ingress {
    description     = "http access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name  = "Web_SG"
    Owner = "Sara_Mousa"
  }
}



# Creating the bastion security group
resource "aws_security_group" "bastion_sg" {
  name   = "Bastion_SG"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Bastion_SG"
    Owner = "Sara_Mousa"
  }
}


# create security group for the Database
resource "aws_security_group" "db_sg" {
  name        = "DB_SG"
  description = "enable mysql access on port 3305 from client-sg"
  vpc_id      = var.vpc_id

  ingress {
    description     = "mysql access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "DB_SG"
    Owner = "Sara_Mousa"
  }
}
