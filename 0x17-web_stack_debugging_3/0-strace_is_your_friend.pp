# This Puppet manifest is designed to troubleshoot and fix issues with an Apache server 
# running a WordPress site on an Ubuntu server. It ensures that PHP error logging is 
# configured correctly, checks and corrects file permissions, and restarts the Apache service.

class apache_wordpress_fix {
  
  # Ensure that the php_errors.log file exists and has the correct permissions
  file { '/var/log/php_errors.log':
    ensure  => 'present',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0644',
  }

  # Ensure the php.ini file has the correct settings for error logging
  augeas { 'php.ini_error_log':
    context => '/files/etc/php5/apache2/php.ini',
    changes => [
      "set PHP/error_log '/var/log/php_errors.log'",
      "set PHP/log_errors 'On'"
    ],
    notify  => Service['apache2'],
  }

  # Restart the Apache service to apply the changes
  service { 'apache2':
    ensure     => 'running',
    enable     => true,
    subscribe  => File['/var/log/php_errors.log'],
  }

  # Fix file permissions for WordPress directories
  file { '/var/www/html/wp-content/plugins':
    ensure  => 'directory',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
  }
  
  file { '/var/www/html/wp-content/themes':
    ensure  => 'directory',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
  }

  # Restart Apache after all changes are made
  exec { 'restart_apache':
    command     => '/usr/sbin/service apache2 restart',
    refreshonly => true,
    subscribe   => [ File['/var/log/php_errors.log'], File['/var/www/html/wp-content/plugins'], File['/var/www/html/wp-content/themes'] ],
  }

}

include apache_wordpress_fix

