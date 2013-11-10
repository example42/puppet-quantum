# Class: quantum::params
#
# Defines all the variables used in the module.
#
class quantum::params {

  $package_name = $::osfamily ? {
    'Redhat' => 'openstack-quantum',
    default  => 'quantum-server',
  }

  $service_name = $::osfamily ? {
    'Redhat' => 'openstack-quantum',
    default  => 'quantum',
  }

  $config_file_path = $::osfamily ? {
    default => '/etc/quantum/quantum.conf',
  }

  $config_file_mode = $::osfamily ? {
    default => '0644',
  }

  $config_file_owner = $::osfamily ? {
    default => 'root',
  }

  $config_file_group = $::osfamily ? {
    default => 'root',
  }

  $config_dir_path = $::osfamily ? {
    default => '/etc/quantum',
  }

  case $::osfamily {
    'Debian','RedHat','Amazon': { }
    default: {
      fail("${::operatingsystem} not supported. Review params.pp for extending support.")
    }
  }
}
