#!/bin/sh
##############################################################
# Based on Script by Ruslan Khissamov(rrkhissamov@gmail.com)
##############################################################
# Add MongoDB Package
echo 'Add MongoDB Package'
echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'MongoDB Package completed'
# Update System
echo 'System Update'
apt-get -y update
echo 'Update completed'
# Install help app
apt-get -y install libssl-dev git-core pkg-config build-essential curl gcc g++ wget ssh openssh-client openssh-server checkinstall

# Backup original ssh config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original
chmod a-w /etc/ssh/sshd_config.original
# Start ssh server
sudo /etc/init.d/ssh restart

# Download & Unpack Node.js - v. 0.6.10
echo 'Download Node.js - v. 0.6.10'
mkdir /tmp/node-install
cd /tmp/node-install
wget http://nodejs.org/dist/v0.6.10/node-v0.6.10.tar.gz
tar -zxf node-v0.6.10.tar.gz
echo 'Node.js download & unpack completed'
# Install Node.js
echo 'Install Node.js'
cd node-v0.6.10
./configure && make && checkinstall --install=yes --pkgname=nodejs --pkgversion "0.6.10" --default
echo 'Node.js install completed'
# Install Cloud9IDE
echo 'Install Cloud9IDE'
git clone git://github.com/ajaxorg/cloud9.git
echo 'Cloud9IDE install completed'

# Node Packages
echo 'Install Node packages'
npm install -g coffee-script
npm install cradle underscore request express redis jsdom connect async jquery jade stylus uglify-js socket.io
echo 'Node packages install completed'

# Ruby On Rails
echo 'Install Ruby On Rails'
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
source ~/.bash_profile
rvm requirements
rvm install 1.9.3
rvm --default use 1.9.3
gem install rails
echo 'Ruby On Rails install completed'

# PHP and Apache
echo 'Install PHP and Apache'
apt-get install apache2 php5 libapache2-mod-php5
/etc/init.d/apache2 restart
echo 'PHP and Apached install completed'

# Java
echo 'Install Java'
apt-get install sun-java6-jdk sun-java6-jre
echo 'Java install completed'

# Install PostgreSQL
echo 'Install PostgreSQL'
apt-get -y install postgresql
echo 'Install PostgreSQL install completed.'
echo 'Official instructions for setting Ubuntu 11.04'
echo 'https://help.ubuntu.com/11.04/serverguide/C/postgresql.html'
# Install MySQL
echo 'Install MySQL'
apt-get -y install mysql-server
echo 'MySQL install completed.'
echo 'Official instructions for setting Ubuntu 11.04'
echo 'https://help.ubuntu.com/11.04/serverguide/C/mysql.html'
# Install MongoDB
echo 'Install MongoDB'
apt-get -y install mongodb-10gen
echo 'MongoDB install completed.'
# Install CouchDB
echo 'Install CouchDB'
apt-get -y install couchdb
echo 'CouchDB install completed.'
# Install Redis
echo 'Install Redis'
cd /tmp
mkdir redis && cd redis
wget http://redis.googlecode.com/files/redis-2.4.6.tar.gz
tar -zxf redis-2.4.6.tar.gz
cd redis-2.4.6
make && make install
wget https://github.com/ijonas/dotfiles/raw/master/etc/init.d/redis-server
wget https://github.com/ijonas/dotfiles/raw/master/etc/redis.conf
mv redis-server /etc/init.d/redis-server
chmod +x /etc/init.d/redis-server
mv redis.conf /etc/redis.conf
useradd redis
mkdir -p /var/lib/redis
mkdir -p /var/log/redis
chown redis.redis /var/lib/redis
chown redis.redis /var/log/redis
update-rc.d redis-server defaults
echo 'Redis install completed. Run "sudo /etc/init.d/redis-server start"'
