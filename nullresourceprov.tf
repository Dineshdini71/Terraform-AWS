resource "null_resource" "prod-remote_exec" {
  count = var.environment == "dev" || var.environment == "DEV" ? 1 : 1
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Newly.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.PUBLIC-WEB-SERVERS.*.public_ip, count.index)
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
      "sudo apt update ",
      "sudo apt install -y unzip",
      "cd /tmp && sudo rm -rf terraform && wget https://releases.hashicorp.com/terraform/1.4.5/terraform_1.4.5_linux_amd64.zip && sudo unzip terraform_1.4.5_linux_amd64.zip && ./terraform version",

    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("Newly.pem")
      #host     = "${aws_instance.web-1.public_ip}"
      host = element(aws_instance.PUBLIC-WEB-SERVERS.*.public_ip, count.index)
    }
  }
  provisioner "local-exec" {
    command = <<EOH
      echo "${element(aws_instance.PUBLIC-WEB-SERVERS.*.public_ip, count.index)}" >> public_ip_details.txt && echo "${element(aws_instance.PUBLIC-WEB-SERVERS.*.private_ip, count.index)}" >> private_ip_details.txt,
    EOH
  }
}