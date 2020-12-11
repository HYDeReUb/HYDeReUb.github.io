#!/bin/bash
dnf -y update

# install Apache httpd
dnf install -y httpd httpd-tools 
systemctl start httpd
systemctl enable httpd

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# install MariaDB
dnf -y install mariadb-server mariadb

systemctl start mariadb
systemctl enable mariadb

dnf -y install expect

read -p "Type the password you just entered (MySQL): " MYSQL_ROOT_PASSWORD

SECURE_MYSQL=$(expect -c "

set timeout 10
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$MYSQL\r\"

expect \"Set root password?\"
send \"y\r\"

expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

dnf -y remove expect

# intall PHP 7
dnf -y install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf module list php
dnf -y module reset php
dnf -y module enable php:remi-7.4
dnf -y install php php-fpm php-cli php-json php-mysqlnd php-opcache php-gd php-ldap php-odbc php-pdo php-bcmath php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-pecl-zip curl curl-devel

sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php.ini
#sed -i 's/apache$/nginx/' /etc/php-fpm.d/www.conf
sed -i 's/;listen.acl_groups =/listen.acl_groups = apache,nginx/' /etc/php-fpm.d/www.conf
#sed -i 's/;listen.mode = 0660/listen.mode = 0666/' /etc/php-fpm.d/www.conf

#chgrp -R nginx /var/lib/php/{opcache,session,wsdlcache}

systemctl start php-fpm
systemctl enable php-fpm

setsebool -P httpd_execmem 1

systemctl restart httpd

# install PhpMyAdmin
read -p "Do you want to install PhpMyAdmin? <y/N> " prompt
if [ "$prompt" = "y" ]; then
	export VER="4.9.5"
	cd /tmp
	curl -O https://files.phpmyadmin.net/phpMyAdmin/${VER}/phpMyAdmin-${VER}-all-languages.tar.gz
	tar xvf phpMyAdmin-${VER}-all-languages.tar.gz -C /usr/share
	mv /usr/share/phpMyAdmin-${VER}-all-languages /usr/share/phpmyadmin
	rm -f phpMyAdmin-${VER}-all-languages.tar.gz
#	ln -s /usr/share/phpmyadmin /usr/share/nginx/html
	ln -s /usr/share/phpmyadmin /var/www/html/
	echo "http://localhost/phpmyadmin to enter PhpMyAdmin"
	systemctl restart httpd
fi

# install composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm -f composer-setup.php

# For Laravel: enable Apache mod_rewrite module
# service apache2 restart
apachectl -t -D DUMP_MODULES | grep rewrite

# Set up an Apache virtual host for your Laravel project.
#mkdir -p /var/www/4070e999/html

# create directory for virtual hosts site configuration
mkdir /etc/httpd/sites-available
mkdir /etc/httpd/sites-enabled
