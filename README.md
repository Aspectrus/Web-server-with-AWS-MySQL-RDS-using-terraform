# Web-server-with-AWS-MySQL-RDS-using-terraform

This terraform creates and AWS apache WEB server and MySQL RDS. Configures VPC what only the WEB server has access to internet,
DB is only accessible from WEB server. Also uses AWS ELB, number of servers are specified like this:

`terraform apply -var 'number_of_instances=2`

index.php file is automatically added to server.
