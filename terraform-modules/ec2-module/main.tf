resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = var.instance_name  # ✅ Tags should be inside the resource block
  }

  # SSH Connection for Remote Execution
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key
    host        = self.public_ip
  }

  # Provisioner to run commands on the remote EC2 instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx"
    ]
  }

  # Provisioner to execute a local command after EC2 creation
  provisioner "local-exec" {
    command = "echo 'EC2 instance ${self.public_ip} created!'"
  }
}