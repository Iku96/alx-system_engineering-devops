# A manifest that installs flask version 2.1.3

# Ensure pip3 is installed
package {'python3-pip':
  ensure => 'installed'
}

# Install flask version 2.1.0 and werkzeug ver 2.1.1 using pip3
exec {'install_flask_werkzeug':
  command => '/usr/bin/pip3 install flask==2.1.0 werkzeug==2.1.1',
  path    => ['/usr/bin', '/bin'],
  unless  => '/usr/bin/pip3 show flask | grep -q "Version: 2.1.0" && /usr/bin/pip3 show werkzeug | grep -q "Version: 2.1.1"',
}
