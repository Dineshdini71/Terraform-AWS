resource "local_file" "inventory" {
  content = templatefile("publicservers.tpl",
    {
      testserver01 = aws_instance.PUBLIC-WEB-SERVERS.0.public_ip
      testserver02 = aws_instance.PUBLIC-WEB-SERVERS.1.public_ip
      testserver03 = aws_instance.PUBLIC-WEB-SERVERS.2.public_ip


      pvttestserver01 = aws_instance.PUBLIC-WEB-SERVERS.0.public_ip
      pvttestserver02 = aws_instance.PUBLIC-WEB-SERVERS.1.public_ip
      pvttestserver03 = aws_instance.PUBLIC-WEB-SERVERS.2.public_ip
    }
  )
  filename = "invfile"
}