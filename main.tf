
// Visual Studio Terraformo dont sopport the HCL2  , i'm using the
// interpolation 0-11


provider "aws" {
  profile = "${var.profile}" // 
  region  = "${var.region}" // EE.UU. Este (Ohio)
  version = "~> 2.21"
}


resource "aws_instance" "example" {
    ami           = "ami-05c1fa8df71875112"
  instance_type = "t2.micro" 

  provisioner "local-exec" { // only run when is create a resource
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
