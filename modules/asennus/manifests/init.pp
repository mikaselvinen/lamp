class asennus{

	Package { ensure => 'installed', allowcdrom => "true" }
		package { 'apache2':}
		package { 'ssh':}
                package { 'php':}
                package { 'libapache2-mod-php':}


	file{"/var/www/html/index.html":
		content => "Hello world!\n",
	}

	file{"/home/xubuntu/public_html/index.php":
		content => template("asennus/index.php")

	}

	file{"/etc/apache2/mods-enabled/userdir.conf":
		ensure => "link",
		target => "../mods-available/userdir.conf",
		notify => Service["apache2"],
	}

	file{"/etc/apache2/mods-enabled/userdir.load":
		ensure => 'link',
		target => '../mods-available/userdir.load',
		notify => Service["apache2"],
	}

	file { "/etc/apache2/mods-available/php7.0.conf":
		content => template("asennus/php7.0.conf"),
                notify => Service["apache2"],
        }

	service {"apache2":
		ensure => "true",
		enable => "true",
	}
}

