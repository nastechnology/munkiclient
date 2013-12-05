class munkiclient::config {
  $software_repo_url = "https://munkiwa.nas.local/munki_repo"

  file {'/Library/Preferences/ManagedInstalls.plist':
    ensure  => present,
    owner   => root,
    group   => admin,
    require => Package['munkitools-0_9_2_1851_0.dmg'],
  }

  exec { 'SoftwareRepoURL':
    command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL '${software_repo_url}'",
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }
  
  #exec { 'SoftwareRepoCACertificate':
  #  command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls SoftwareRepoCACertificate '/usr/local/munki/munkiwa.nas.local.cert'",
  #  require => File['/Library/Preferences/ManagedInstalls.plist'],
  #}

  exec { 'LoggingLevel':
    command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls LoggingLevel -int 1",
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }

  exec { 'DaysBetweenNotifications':
    command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls DaysBetweenNotifications -int 1",
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }
  
  exec { 'ClientIdentifier':
    command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls ClientIdentifier '${hostname}.nas.local'",
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }

  exec { 'InstallAppleSoftwareUpdates':
    command => "/usr/bin/defaults write /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates -bool TRUE",
    require => File['/Library/Preferences/ManagedInstalls.plist'],
  }
}
