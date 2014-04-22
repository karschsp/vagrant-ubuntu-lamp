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
}

include base
include apache2
include mysql
include php
