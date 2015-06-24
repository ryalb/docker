#!/bin/bash

echo -e "\n##############################################"
echo -e "\n# Setup Apache2 and PHP configuration files..."
echo -e "\n##############################################"

cd /etc/php5/apache2/conf.d/
unlink xdebug.ini 2> /dev/null
ln -s /config/xdebug.ini
chmod 644 /etc/php5/apache2/conf.d/xdebug.ini

cd /etc/apache2/sites-available
unlink 100-doppler.conf 2> /dev/null
ln -s /config/100-doppler.conf
chmod 644 /etc/apache2/sites-available/100-doppler.conf

unlink /etc/php5/apache2/conf.d/20-xdebug.ini

echo "Creating xdebug log directory: /var/log/xdebug"
mkdir /var/log/xdebug 2> /dev/null

echo "Changing xdebug log directory owner to www-data"
chown www-data:www-data /var/log/xdebug

echo "Installing xdebug"
pecl install xdebug

# enable modules
a2enmod rewrite
a2enmod headers
a2enmod ssl
a2enmod python

# enable sites
a2ensite 100-doppler

# disable sites
a2dissite 000-default

# reload apache2
service apache2 reload

# load apache on boot
update-rc.d apache2 defaults
