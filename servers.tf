#---------------create aws mysql rds instance
resource "aws_db_instance" "my_database_instance" {
allocated_storage = 20
storage_type = "gp2"
engine = "mysql"
engine_version = "5.7"
instance_class = "db.t2.micro"
port = 3306
vpc_security_group_ids = ["${aws_security_group.db_security_group.id}"]
db_subnet_group_name = "${aws_db_subnet_group.my_database_subnet_group.name}"
name = "mydb"
identifier = "mysqldb"
username = "myuser"
password = "mypassword"
parameter_group_name = "default.mysql5.7"
skip_final_snapshot = true
tags = {
Name = "my_database_instance"
}
}
#-----------------create EC2 instance
resource "aws_instance" "my_web_instance" {
ami = "ami-0323c3dd2da7fb37d"
count = var.number_of_instances
instance_type = "t2.micro"
key_name = "${aws_key_pair.deployer.key_name}"
vpc_security_group_ids = ["${aws_security_group.web_security_group.id}"]
subnet_id = "${aws_subnet.myvpc_public_subnet.id}"
tags =   {
Name = "my_web_instance"
}
volume_tags = {
Name = "my_web_instance_volume"
}

provisioner "remote-exec" {
inline = [
"sudo mkdir -p /var/www/html/",
"cd /var/www/html/",
"sudo yum update -y",
"sudo yum install -y httpd",
"sudo service httpd start",
"sudo usermod -a -G apache ec2-user",
"sudo chown -R ec2-user:apache /var/www",
"sudo yum install -y mysql php php-mysql",
"sudo echo ${aws_db_instance.my_database_instance.address} > servername.txt",
"sudo service httpd restart",
]
}
provisioner "file" {
source = "index.php"
destination = "/var/www/html/index.php"
}
connection {
type = "ssh"
user = "ec2-user"
password = ""
private_key = "${tls_private_key.key.private_key_pem}"
host = self.public_ip
}
}