#!/usr/bin/env bash

cd /home/vagrant
sudo -u vagrant curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
sudo -u vagrant sed -i '1i export PATH="/home/vagrant/.composer/vendor/bin:$PATH"' /home/vagrant/.bashrc
sudo -u vagrant /usr/local/bin/composer global require drush/drush:7.*
mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%';FLUSH PRIVILEGES;"
sudo mkdir /var/www/site-php
sudo mkdir /var/www/site-php/rodaled7
sudo chmod -R 777 /var/www/site-php

# INSTALL SOLR
# run command: sudo ./installsolr.sh
# final solr url will be: http://localhost:8983/solr/core0
# will install the files at /opt/solr4104
# command: sudo ./solrinstall.sh

#stop the existing solr install
#sudo killall java
#install new solr
#uncomment the below and to use wget and comment out the the curl line
#curl -O http://apache.mirrors.lucidnetworks.net/lucene/solr/4.10.4/solr-4.10.4.tgz
#tar -xvf solr-4.10.4.tgz
#sudo mv solr-4.10.4 /opt/solr4104
#cd /opt/solr4104
#sudo rm -Rf *.txt docs
#cd example
#sudo cp -R contexts etc lib logs resources start.jar webapps solr-webapp multicore ..
#cd ..
#sudo mv multicore solr
#sudo rm -Rf solr/README.txt
#copy the solr core0 with configs to the solr location
#echo "removed and copied files, starting server..."
#sudo cp -Rf /vagrant/src/core0 /opt/solr4104/solr
#sudo java -jar -Dsolr.solr.home=/opt/solr4104/solr start.jar >>log.txt 2>&1 &
