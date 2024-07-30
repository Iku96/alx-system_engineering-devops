# A manifest that installs flask version 2.1.3

# Ensure pip3 is installed
package {'python3-pip':
  ensure => 'installed'
}

# Install flask version 2.1.0 using pip3
exec {'install_flask':
  command => '/usr/bin/pip3/ install flask==2.1.0',
  path    => ['/usr/bin', '/bin'],
  unless  => '/usr/bin/pip3/ show flask | grep -q "version: 2.1.0"',
}
