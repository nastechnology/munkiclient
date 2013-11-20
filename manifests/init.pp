class munkiclient {
  exec {"/sbin/reboot":
    refreshonly => true,
  }

  schedule { 'maintenance':
    period => hourly,
    repeat => 2
  }

  package { 'munkitools-0.9.2.1851.0.dmg' :
    provider => pkgdmg,
    alias    => 'munkitools',
    ensure   => installed,
    source   => 'http://munkibuilds.org/0.9.2.1851.0/munkitools-0.9.2.1851.0.dmg',
#    schedule => maintenance,
    notify   => Exec["/sbin/reboot"],
  }

  package { 'munkiwebadmin_scripts-2013.11.20.dmg':
    provider => pkgdmg,
    alias    => 'munkiwebadmin',
    ensure   => installed,
    source   => 'http://tech.napoleonareaschools.org/munkiwebadmin_scripts-2013.11.20.dmg',
#    schedule => maintenance,
  }
}
