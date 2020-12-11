#!/bin/bash

# install Ningx
dnf -y install nginx
systemctl start nginx
systemctl enable nginx

firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

# intall PHP
dnf -y install epel-release
dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf -y module enable php:remi-8.0
dnf -y install php php-fpm php-cli php-json php-mysqlnd php-opcache php-gd php-ldap php-odbc php-pdo php-bcmath php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-pecl-zip curl curl-devel

sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php.ini
sed -i 's/apache$/nginx/' /etc/php-fpm.d/www.conf
sed -i 's/;listen.acl_groups =/listen.acl_groups = apache,nginx/' /etc/php-fpm.d/www.conf
#sed -i 's/;listen.mode = 0660/listen.mode = 0666/' /etc/php-fpm.d/www.conf

chgrp -R nginx /var/lib/php/{opcache,session,wsdlcache}

systemctl start php-fpm
systemctl enable php-fpm

cat > /etc/nginx/conf.d/ksuie.com.conf << "EOF"
# ksuie.com server configuration
server {
	listen 80;
	listen [::]:80;
	
	server_name ksuie.com www.ksuie.com;
	root /var/www/ksuie.com/public;
	index index.php index.html index.htm default.html;
	location / {
		try_files $uri $uri/ =404;
	}
	# pass the PHP scripts to FastCGI server
	location ~ \.php$ {
		fastcgi_pass unix:/run/php-fpm/www.sock;
		fastcgi_index  index.php;
		try_files $uri =404;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
#		fastcgi_param  PATH_INFO $fastcgi_path_info;
		include     fastcgi_params;
	}
	
	# optimize static file serving
	location ~* \.(jpg|jpeg|gif|png|css|js|ico|xml)$ {
		access_log off;
		log_not_found off;
		expires 30d;
	}
	# deny access to .htaccess files, should an Apache document root conflict with nginx
	location ~ /\.ht {
		deny all;
	}
}
EOF

mkdir -p /var/www/ksuie.com/public
cat > /var/www/ksuie.com/public/index.php << "EOF"
<?php
class Application
{
	public function __construct()
	{
		echo 'Hi ksuie.com';
	}
}
$application = new Application();
EOF

rm -rf /var/www/html

service nginx restart

cat >> /etc/hosts << "EOF"
127.0.0.1 ksuie.com 
EOF

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

# install PhpMyAdmin
read -p "Do you want to install PhpMyAdmin? <y/N> " prompt
if [ "$prompt" = "y" ]; then
	export VER="4.9.7"
	cd /tmp
	curl -O https://files.phpmyadmin.net/phpMyAdmin/${VER}/phpMyAdmin-${VER}-all-languages.tar.gz
	tar xvf phpMyAdmin-${VER}-all-languages.tar.gz -C /usr/share
	mv /usr/share/phpMyAdmin-${VER}-all-languages /usr/share/phpmyadmin
	rm -f phpMyAdmin-${VER}-all-languages.tar.gz
	ln -s /usr/share/phpmyadmin /usr/share/nginx/html
	mkdir /usr/share/phpmyadmin/tmp
	chgrp -R nginx /usr/share/phpmyadmin/tmp
	chcon -t httpd_sys_content_rw_t /usr/share/phpmyadmin/tmp
    chmod g+w /usr/share/phpmyadmin/tmp
	echo "http://localhost/phpmyadmin to enter PhpMyAdmin"
	systemctl restart nginx
fi

# install composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm -f composer-setup.php
