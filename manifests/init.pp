class munkiclient {
  $software_repo_url = "https://munkiwa.nas.local/munki_repo"

  schedule { 'maintenance':
    period => hourly,
    repeat => 2
  }

  package { 'munkitools-latest.dmg' :
    provider => pkgdmg,
    alias    => 'munkitools',
    ensure   => installed,
    source   => 'http://munkibuilds.org/munkitools-latest.dmg',
    schedule => maintenance,
    notify   => Exec["/sbin/reboot"],
  }

  package { 'munkiwebadmin.dmg':
    provider => pkgdmg,
    alias    => 'munkiwebadmin',
    ensure   => installed,
    source   => 'https://munkiwa.nas.local/munki_repo/munkiwebadmin.dmg',
    schedule => maintenance,
  }

  exec {"/sbin/reboot":
    refreshonly => true,
  }

  file {'/Library/Preferences/ManagedInstalls.plist':
    ensure => present,
    owner => root,
    group => admin,
  }

  property_list_key { 'SoftwareRepoURL':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'SoftwareRepoURL',
    value  => $software_repo_url,
  }

  property_list_key { 'SoftwareRepoCACertificate':
    ensure  => present,
    path    => '/Library/Preferences/ManagedInstalls.plist',
    key     => 'SoftwareRepoCACertificate',
    value   => '/usr/local/munki/munkiwa.nas.local.cert',
    require => Package['munkiwebadmin.dmg'],
  }

  property_list_key { 'LoggingLevel':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'LoggingLevel',
    value  => 1,
    value_type=> 'integer',
  }

  property_list_key { 'DaysBetweenNotifications':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'DaysBetweenNotifications',
    value  => 1,
    value_type => 'integer',
  }

  property_list_key { 'ClientIdentifier':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'ClientIdentifier',
    value  => "$::{hostname}.nas.local",
    value_type => 'string',
  }

  property_list_key { 'InstallAppleSoftwareUpdates':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'InstallAppleSoftwareUpdates',
    value  => true,
    value_type => 'boolean',
  }

}
