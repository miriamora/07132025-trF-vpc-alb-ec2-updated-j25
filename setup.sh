#!/bin/bash
sudo yum update -y
sudo yum install -y httpd

sudo systemctl start httpd
sudo systemctl enable httpd

echo "<html>
  <h1><p>Welcome to my Myself domain.<br> Here is ${HOSTNAME}.<br>
  Feel free to reach out if you have any questions!</p></h1>
</html>" | sudo tee /var/www/html/index.html > /dev/null
