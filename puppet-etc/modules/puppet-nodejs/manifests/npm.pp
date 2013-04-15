define nodejs::npm (
  $ensure      = present,
  $version     = undef,
  $source      = undef,
  $install_opt = undef,
  $remove_opt  = undef
) {
  $npm = split($name, ':')
  $npm_dir = $npm[0]
  $npm_pkg = $npm[1]

  if $source {
    $install_pkg = $source
  } elsif $version {
    $install_pkg = "${npm_pkg}@${version}"
  } else {
    $install_pkg = $npm_pkg
  }

  if $version {
    $validate = "${npm_dir}/node_modules/${npm_pkg}:${npm_pkg}@${version}"
  } else {
    $validate = "${npm_dir}/node_modules/${npm_pkg}"
  }

  if $ensure == present {
    exec { "npm_install_${name}":
      command => "npm install ${install_opt} ${install_pkg}",
      unless  => "npm list -p -l | grep '${validate}'",
      cwd     => $npm_dir,
      path    => $::path,
      require => Class['nodejs'],
    }
  } else {
    exec { "npm_remove_${name}":
      command => "npm remove ${npm_pkg}",
      onlyif  => "npm list -p -l | grep '${validate}'",
      cwd     => $npm_dir,
      path    => $::path,
      require => Class['nodejs'],
    }
  }
}
