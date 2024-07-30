/* A puppet manifest that creates a file in tmp which contains
the words "I love Puppet". */ 

file {'/tmp/school':
  ensure  => 'file',
  content => 'I love Puppet',
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
}
