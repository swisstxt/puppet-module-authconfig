define authconfig::sssd::param(
  $value,
  $section = 'domain/default'
) {
  if is_string($value) or $value {
    $changes = "set target[. = '${section}']/${name} ${value}"
  } else {
    $changes = "rm target[. = '${section}']/${name}"
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
