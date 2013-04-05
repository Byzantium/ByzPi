class ifplugd {
	package { 'ifplugd': ensure => installed }
	file {
		'/etc/resolv.conf.gateway':
		ensure => file,
		source => 'puppet://modules/ifplugd/files/etc/resolv.conf.gateway',
	}
	file {
		'/etc/ifplugd/ifplugd.conf':
		ensure => file,
		source => 'puppet://modules/ifplugd/files/etc/ifplugd/ifplugd.conf',
	}
	file {
		'/etc/ifplugd/ifplugd.action':
		ensure => file,
		source => 'puppet://modules/ifplugd/files/etc/ifplugd/ifplugd.action',
	}
	file {
		'/etc/avahi/avahi-dnsconfd.action':
		ensure => file,
		source => 'puppet://modules/ifplugd/files/etc/avahi/avahi-dnsconfd.action',
	}
}

