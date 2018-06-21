# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name   = "vpctestkeypair"
  public_key = "${file("${var.public_key_path}")}"
}

# Define webserver inside the public subnet
resource "aws_instance" "wb" {
  ami                         = "${var.ami}"
  instance_type               = "t1.micro"
  key_name                    = "${aws_key_pair.default.id}"
  subnet_id                   = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids      = ["${aws_security_group.sgweb.id}"]
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name       = "tf-vpc-instance"
    created_by = "john.mccabe@puppet.com"
    department = "engineering"
    project    = "incubator-tfcomparison"
    lifetime   = "1h"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("${var.private_key_path}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update",
      "sudo apt -y install nginx",
      "sudo rm -rf /var/www/html/index.html",
      "echo '<html><head><title>Installed by Terraform</title></head><body><h1>INSTALLED BY TERRAFORM</h1></body></html>' | sudo tee /var/www/html/index.html",
    ]
  }
}
