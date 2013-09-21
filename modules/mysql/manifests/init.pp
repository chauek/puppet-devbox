class mysql {
    # Install mysql
    package { "mysql-server":
        ensure => latest,
        require => Exec['apt-get update']
    }

    # Enable the MySQL service
    service { "mysql":
        enable => true,
        ensure => running,
        require => Package["mysql-server"],
    }

    # Set MySQL password to "root"
    exec { "set-mysql-password":
        unless => "mysqladmin -uroot -proot status",
        command => "mysqladmin -uroot password root",
        require => Service["mysql"],
    }
    
    exec { 'mysql-root':
        command => 'mysql -u root -proot mysql -e "update mysql.user set host=\'%\' where user=\'root\' and host=\'localhost\';flush privileges;"',
        require => Exec["set-mysql-password"]
    }
}
