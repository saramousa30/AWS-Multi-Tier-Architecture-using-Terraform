# ----------------------------------------------------------------------------- #
# ------------------------------- EC2 Module ---------------------------------- #
# ----------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------
# Creating Instance
# -------------------------------------------------------------------------------
resource "aws_instance" "bastion_instances" {
  count                       = var.create_bastion ? var.bastion_instance_count : 0
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[count.index]
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = true

  tags = {
    Name  = "Bastion Host_${count.index + 1}"
    Owner = "Sara_Mousa"
  }
}

resource "aws_instance" "web_instances" {
  count                       = var.create_web_instance ? var.web_instance_count : 0
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[count.index]
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.web_sg_id]
  associate_public_ip_address = false

  tags = {
    Name  = "Web Server_${count.index + 1}"
    Owner = "Sara_Mousa"
  }

  #This block tells Terraform how to SSH into the EC2 instance.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.key_name
    host        = self.private_ip

    #"I can’t connect to the private EC2 directly — instead, I will first SSH into the bastion (which has a public IP), and from there jump into the private EC2."
    #This uses SSH tunneling automatically
    bastion_host        = aws_instance.bastion_instances[count.index].public_ip
    bastion_user        = "ubuntu"
    bastion_private_key = var.key_name
  }


  provisioner "remote-exec" {
    #This is a list of shell commands to run inside the EC2 instance.
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",

      #Start and enable Nginx
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",

      #Create a custom web page
      "echo '<html><body><h1>Welcome to my Website! </h1>By:Sara Mousa </h1>Hostname: $(hostname -f)</body></html>' | sudo tee /var/www/html/index.html",

      # Restart Nginx to apply the changes
      "sudo systemctl restart nginx",
      "sudo systemctl enable nginx"

    ]
  }
















}


