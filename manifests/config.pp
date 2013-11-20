class munkiclient::config {
  $software_repo_url = "https://munkiwa.nas.local/munki_repo"

  file {'/Library/Preferences/ManagedInstalls.plist':
    ensure  => present,
    owner   => root,
    group   => admin,
    require => Package['munkitools'],
  }

  property_list_key { 'SoftwareRepoURL':
    ensure  => present,
    path    => '/Library/Preferences/ManagedInstalls.plist',
    key     => 'SoftwareRepoURL',
    value   => $software_repo_url,
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }
  property_list_key { 'SoftwareRepoCACertificate':
    ensure  => present,
    path    => '/Library/Preferences/ManagedInstalls.plist',
    key     => 'SoftwareRepoCACertificate',
    value   => '/usr/local/munki/munkiwa.nas.local.cert',
  }

  property_list_key { 'LoggingLevel':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'LoggingLevel',
    value  => 1,
    value_type=> 'integer',
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }

  property_list_key { 'DaysBetweenNotifications':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'DaysBetweenNotifications',
    value  => 1,
    value_type => 'integer',
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }
  
  property_list_key { 'ClientIdentifier':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'ClientIdentifier',
    value  => "${hostname}.nas.local",
    value_type => 'string',
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }

  property_list_key { 'InstallAppleSoftwareUpdates':
    ensure => present,
    path   => '/Library/Preferences/ManagedInstalls.plist',
    key    => 'InstallAppleSoftwareUpdates',
    value  => true,
    value_type => 'boolean',
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }
}
