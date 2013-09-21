class git {
    # Install git
    package { "git":
        ensure => latest,
        require => Exec['apt-get update']
    }

    # Set the configuration
    file { "/home/vagrant/.gitconfig":
        ensure => file,
        replace => false,
        owner => "vagrant",
        group => "vagrant",
        source => "puppet:///modules/git/gitconfig"
    }

    # Set ignores
    file { "/home/vagrant/.gitignore":
        ensure => file,
        replace => false,
        owner => "vagrant",
        group => "vagrant",
        source => "puppet:///modules/git/gitignore"
    }
}
