class authconfig(
  $shadow = true,
  $passalgo = 'sha512',
  $locauthorize = true,
  $mkhomedir = false,
  $cachecreds = true,
  $sssd = false,
  $sssdauth = false,
  $ldap = false,
  $ldapauth = false,
  $ldapbasedn = undef,
  $ldaploadcacert = undef,
  $nis = false,
  $krb5 = false,
  $sssd_ldapbinddn = false,
  $sssd_ldapbindpw = false
) {
  include authconfig::sssd

  package{'pam_ldap':
    ensure => present,
  } ->
  file{'/var/lib/puppet/authconfig':
    ensure => directory,
  } ->
  file{'/var/lib/puppet/authconfig/cmd':
    content => template('authconfig/cmd.erb'),
    mode => '0770',
  } ~>
  exec{'authconfig':
    command => '/var/lib/puppet/authconfig/cmd',
    refreshonly => true,
  }
}
