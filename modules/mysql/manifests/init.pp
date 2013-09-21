class mysql {
    # Install mysql
    package { "mysql-server":
        ensure => latest,
        require => Exec['apt-get update']
    }
    
    exec { 'mysql-open-port':
		command => "sed -i 's/bind-address/# bind-address/g' /etc/mysql/my.cnf",
        require => Package["mysql-server"],
        notify  => Service['mysql']
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
        require => Service["mysql"]
    }
    
    exec { 'mysql-root':
        command => 'mysql -u root -proot mysql -e "GRANT ALL PRIVILEGES ON *.* TO \'root\'@\'%\' IDENTIFIED BY \'root\';flush privileges;"',
        require => Exec["set-mysql-password"]
    }

    
}
