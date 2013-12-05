class munkiclient {
  exec {"/sbin/reboot":
    refreshonly => true,
  }

  schedule { 'maintenance':
    period => hourly,
    repeat => 2
  }

  package { 'munkitools-0_9_2_1851_0.dmg' :
    provider => pkgdmg,
    alias    => 'munkitools',
    ensure   => installed,
    source   => 'http://munkibuilds.org/munkitools-latest.dmg',
#    schedule => maintenance,
    notify   => Exec["/sbin/reboot"],
  }

  package { 'munkiwebadmin_scripts-2013.11.20.dmg':
    provider => pkgdmg,
    alias    => 'munkiwebadmin',
    ensure   => installed,
    source   => 'http://tech.napoleonareaschools.org/munkiwebadmin_scripts-2013.11.20.dmg',
    require  => Package['munkitools-0_9_2_1851_0.dmg'],
#    schedule => maintenance,
  }
}
