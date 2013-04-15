class { 'nodejs':
  node_ver => 'v0.8.4'
}

package { 'express':
    ensure      => '2.5.8'
  , provider    => 'npm'
  , require     => Class['nodejs']
}

nodejs::npm { '/tmp:express':
    ensure      => 'present'
  , version     => 'latest'
  , require     => Class['nodejs']
}
