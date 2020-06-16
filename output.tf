#------------output webserver and dbserver address

/*
output "db_server_address" {
value = "${aws_db_instance.my_database_instance.address}"
}

*/

output "private_key" {
value = "${tls_private_key.key.private_key_pem}"
}
output "web_server_address" {
value = "${aws_instance.my_web_instance[*].public_dns}"

}
output "balancer_dns" {
value = "${aws_elb.elb.dns_name}"
 depends_on = [tls_private_key.key]
}