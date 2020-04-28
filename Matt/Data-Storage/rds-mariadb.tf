# Subnet group to set up RDS in. Private.
resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "mariadb-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.matt-priv-a.id, aws_subnet.matt-priv-b.id]
}

# Mariadb specific parameters for database
resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "mariadb-parameters"
  family      = "mariadb10.3"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

# Instance info
resource "aws_db_instance" "mariadb" {
  allocated_storage    = 100 # 100 GB of storage, gives us more IOPS than a lower number
  engine               = "mariadb"
  engine_version       = "10.3.20"
  instance_class       = "db.t2.micro" # use micro if you want to use the free tier
  identifier           = "mariadb"
  name                 = "mariadb"
  username             = "root"                                  # username
  password             = var.RDS_PASSWORD                        # password, reate random password
  db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name # db group defined above
  parameter_group_name = aws_db_parameter_group.mariadb-parameters.name
  multi_az             = "false" # set to true to have high availability: 2 instances synchronized with each other
  # instance port 3306 access.
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30                                       # how long you’re going to keep your backups
  availability_zone       = aws_subnet.matt-priv-a.availability_zone # prefered AZ
  skip_final_snapshot     = true                                     # skip final snapshot when doing terraform destroy
  tags = {
    Name = "mariadb-instance"
  }
}

output "MariadbEndpoint" {
  value = aws_db_instance.mariadb.endpoint
}
