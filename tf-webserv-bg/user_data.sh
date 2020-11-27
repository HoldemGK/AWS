yum -y update
yum -y install httpd

export MY_IP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Build by Terraform <font color="purple"></font></h2><br><p>

<font color="green">Server PrivateIP: <font color="aqua">$MY_IP<br><br>
<font color="magenta">
<b>Version 1.0</b>
</body>
</html>
EOF

sudo service httpd start
chkconfig httpd on
