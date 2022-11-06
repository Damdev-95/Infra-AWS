# Creating an AWS instance for the Webserver!
resource "aws_instance" "webserver" {

  depends_on = [
    aws_vpc.PythonAPP,
    aws_subnet.private_subnet,
    aws_subnet.subnet2,
    aws_security_group.BH-SG,
    aws_security_group.DB-SG-SSH
  ]
  
  # AMI ID [I have used my PythonAPP AMI which has some softwares pre installed]
  ami = "ami-0162dd7febeafb455"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_subnet.id

  # Keyname and security group are obtained from the reference of their instances created above!
  # Here I am providing the name of the key which is already uploaded on the AWS console.
  key_name = "MyKeyFinal"
  
  # Security groups to use!
  vpc_security_group_ids = [aws_security_group.WS-SG.id]

  tags = {
   Name = "Hello-World App"
  }

  # Installing required softwares into the system!
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/Users/harshitdawar/Github/AWS-CLI/MyKeyFinal.pem")
    host = aws_instance.webserver.public_ip
  }

  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = [
        
        from wsgiref.simple_server import make_server
        def simple_app(environ, start_response):
        """Simplest possible application object"""
        status = '200 OK'
        response_headers = [('Content-type', 'text/plain')]
        start_response(status, response_headers)
        return [b"Hello world!\n"]
        with make_server('', 8000, simple_app) as httpd:
        print("Serving on port 8000...")
        httpd.serve_forever()

        "sudo systemctl enable httpd",
        "sudo systemctl restart httpd"
    ]
  }
}