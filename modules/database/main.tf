data "aws_ssm_parameter" "dbpass" {
  name = "/cloudj/cloudiac/tf-web/db/password"
}

resource "aws_db_instance" "database" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  identifier             = "${var.namespace}-db-instance"
  name                   = "pets"
  username               = "admin"
  password               = data.aws_ssm_parameter.dbpass.value
  db_subnet_group_name   = var.vpc.database_subnet_group #B
  vpc_security_group_ids = [var.sg.db]                   #B
  skip_final_snapshot    = true
}
