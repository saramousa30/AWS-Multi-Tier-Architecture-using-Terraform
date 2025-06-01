# ----------------------------------------------------------------------------- #
# ------------------------------- DB Module ----------------------------------- #
# ----------------------------------------------------------------------------- #

# Create Database subnet group 
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "database subnet group"
  subnet_ids = var.database_subnet_ids
}


resource "aws_db_instance" "db" {
  identifier              = "mysql-database"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_user
  password                = var.db_pass
  db_name                 = var.db_name
  multi_az                = var.multi_az
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 0
  vpc_security_group_ids  = [var.db_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Owner = "Sara_Mousa"
  }
}
