#!/bin/bash

echo -n "Project name (domain.com):"
read project_name

echo -n "PHP version (Recommeneded 8.1):"
read php_version

sudo apt update
sudo apt install php$php_version-xml -y php$php_version -y  php$php_version-fpm -y php$php_version-bcmath -y php$php_version-bz2 -y php$php_version-cli -y php$php_version-common -y php$php_version-curl -y php$php_version-dev -y php$php_version-gd -y php$php_version-igbinary -y php$php_version-imagick -y php$php_version-imap -y php$php_version-intl -y php$php_version-mbstring -y php$php_version-memcached -y php$php_version-msgpack -y php$php_version-mysql -y php$php_version-opcache -y php$php_version-pgsql -y php$php_version-readline -y php$php_version-redis -y php$php_version-soap -y php$php_version-ssh2 -y php$php_version-tidy -y php$php_version-xmlrpc -y php$php_version-zip -y
echo "PHP installed successfully :)"


echo -n "Database name for MySQL: "
read db_name
echo -n "Username for MySQL: "
read db_user
echo -n "Password for MySQL:: "
read db_pass
sudo apt install  mysql-server debconf -y
sudo systemctl start mysql.service

mysql -u root -e "CREATE DATABASE $db_name; CREATE USER '$db_user'@'localhost' IDENTIFIED BY '$db_pass'; GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';"

echo "MySQL has been successfully installed and the database has been created:"



sudo apt-get install -y git composer
echo "Git and Composer installed successfully :)"


ssh-keygen -t rsa -b 4096 -C "$USER@$HOSTNAME"
echo "Please add the following SSH key to https://github.com/user-name/project-name/settings/keys: "
cat ~/.ssh/id_rsa.pub



read -p "SSH key creation completed successfully? (yes/no) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    echo "The transaction has been accepted, the process is in progress..."
else
    echo "The transaction was not accepted, the transaction is being cancelled..."
    exit 1
fi


echo -n "Type the ssh link of your project (git@github.com:USER/Project.git): "
read project_link



git clone $project_link /var/www/$project_name

sudo mv /var/www/$project_name/{,.} /var/www/$project_name




cd /
sudo apt install -y nginx
sudo mkdir -p /var/www/$project_name/public


sudo tee /etc/nginx/sites-available/$project_name <<EOF
server {
        listen 80;
        listen [::]:80;
        server_name $project_name;
        root /var/www/$project_name/public;

        add_header X-Frame-Options "SAMEORIGIN";
        add_header X-Content-Type-Options "nosniff";

        index index.php;

        charset utf-8;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }

        location = /favicon.ico { access_log off; log_not_found off; }
        location = /robots.txt  { access_log off; log_not_found off; }

        error_page 404 /index.php;

        location ~ \.php$ {
            fastcgi_pass unix:/var/run/php/php$php_version-fpm.sock;
            fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
            include fastcgi_params;
        }

        location ~ /\.(?!well-known).* {
            deny all;
        }
}
EOF

sudo nginx -t
sudo systemctl reload nginx



sudo ln -s /etc/nginx/sites-available/$project_name /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
echo "Nginx installed and setup successfully :)"


composer install
echo "Laravel project successfully created and Composer dependencies installed..."


read -p "Do you want to secure your connection(SSL) (yes/no) " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    echo "The transaction has been accepted, the process is in progress..."
else
    echo "The transaction was not accepted, the transaction is being cancelled..."
    exit 1
fi
sudo apt install certbot python3-certbot-nginx -y

echo "SSL Generating <3 😘"



