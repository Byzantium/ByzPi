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

# Nodejs for etherpad

package { [libc-ares2' 'libc6', 'libev4', 'libgcc1', 'libssl1.0.0',
  'libstdc++6', 'libv8-3.8.9.20', 'zlib1g']
  ensure     =>   'present',
}
class { 'nodejs': }
