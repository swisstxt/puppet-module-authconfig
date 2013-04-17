define authconfig::sssd::param(
  $value,
  $section = 'domain/default'
) {
  $changes = is_string($value) ? {
    true  => "set target[. = '${section}']/${name} ${value}",
    false => "rm target[. = '${section}']/${name}",
  }

  augeas{"sssd_${section}_${name}":
    context => '/files/etc/sssd/sssd.conf',
    changes => $changes,
    require => [
      Augeas::Lens['sssd'],
      Exec['authconfig'],
    ],
    notify => Service['sssd'],
  }
}
