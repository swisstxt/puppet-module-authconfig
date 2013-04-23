class authconfig::sssd {
  Class['::authconfig::sssd'] <- Class ['::authconfig']
  include augeas

  $use_sssd = $::authconfig::sssd or $::authconfig::sssd_auth

  augeas::lens{'sssd':
    lens_source => "puppet:///modules/${module_name}/sssd.aug",
    test_source => "puppet:///modules/${module_name}/test_sssd.aug",
    stock_since => '1.0.0',
  } ->
  package{'sssd':
    ensure => present,
  } ->
  service{'sssd':
    enable => $use_sssd,
    ensure => $use_sssd,
    hasrestart => true,
  }
  authconfig::sssd::param{
   'ldap_default_bind_dn':
     value => $::authconfig::sssd_ldapbinddn;
   'ldap_default_auth_ok_type':
     value  => 'password';
   'ldap_default_auth_ok':
     value => $::authconfig::sssd_ldapbindpw;
   'enumerate':
     value => $::authconfig::sssd_enumerate;
  }
}
