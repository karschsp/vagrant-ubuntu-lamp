class base {
  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    alias   => "apt-update",
  }
  package { "git-core":
    ensure => present
  }
  package { "lynx":
    ensure => present
  }
  package { "nano":
    ensure => present
  }
  package { "vim":
    ensure  => present,
  }
  package { "w3m":
    ensure => present,
  }
  package { "telnet":
    ensure  => present,
  }  
  package { "imagemagick":
    ensure => present,
  }
}

class apache2 {
  package { "apache2":
    ensure => present
  }
  service { 'apache2':
    name      => 'apache2',
    require   => Package["apache2"],
    ensure    => running,
    enable    => true
  }
  
  File {
    owner   => "root",
    group   => "root",
    mode    => 644,
    require => Package["apache2"],
    notify  => Service["apache2"]
  }

  package { "apache2-dev":
    ensure  => present
  }

  file { "/etc/apache2/conf.d/vhost.conf":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/apache2/conf.d/vhost.conf",
  }
  
  file { "/etc/apache2/apache2.conf":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/apache2/conf/apache2.conf",
  }  

  # Uncomment if you want to create these folders separately

  file { "/etc/apache2/vhosts_ssl":
    ensure => "directory",
  }
  file { "/vagrant/www":
    ensure => "directory",
  }
  file { "/vagrant/www/drupal7.dev":
    ensure  => "directory",
  }
  file { "/vagrant/www/drupal7.dev/docroot":
    ensure => "directory",
  }
  file { "/vagrant/www/drupal7.dev/log":
    ensure => "directory",
  }  
  file { "/vagrant/www/drupal8.dev":
    ensure  => "directory",
  }
  file { "/vagrant/www/drupal8.dev/docroot":
    ensure => "directory",
  }
  file { "/vagrant/www/drupal8.dev/log":
    ensure => "directory",
  }        

  file { "/etc/apache2/vhosts":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/apache2/vhosts",
    recurse => true,
  }
  
}

class mysql {
  # Installs the MySQL server and MySQL client
  package {
    ['mysql-server',
     'mysql-client']:
      ensure => installed,
  }
  file { "/etc/mysql/my.cnf":
    replace => true,
    ensure  => present,
    require => Package['mysql-server'],
    source  => "/vagrant/files/mysqld/my.cnf",
  }

  service { 'mysql':
    name   => 'mysql',
    require => Package['mysql-server'],
    ensure => running,
    enable => true,
  }
 }
 
 class php {

  package { "php5":
    ensure => present
  }
  package { "php-apc":
    ensure => present
  }
  package { "php5-cli":
    ensure => present
  }
  package { "php5-common":
    ensure => present
  }
  package { "php5-gd":
    ensure => present
  }
  package { "php5-mysql":
    ensure => present
  }
  package { "libapache2-mod-php5":
    ensure => present
  }
}

include base
include apache2
include mysql
include php
