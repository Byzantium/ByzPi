file { '/etc/captiveportal':
  ensure => 'directory',
}
file { '/etc/captiveportal/captiveportal.conf':
  ensure      => 'file',
  mode        => '0644',
  content     => '[/]
tools.staticdir.root = "/srv/captiveportal"

',
  subscribe   => File['/etc/captiveportal'],
}
file { '/srv/captiveportal/':
  ensure      => 'directory',
  mode        => '0644',
}
file { '/srv/captiveportal/':
  source => 'puppet://srv-captiveportal',
  recurse => true,
}
