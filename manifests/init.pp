#
# = Class: quantum
#
# This class installs and manages quantum
#
#
# == Parameters
#
# Refer to https://github.com/stdmod for official documentation
# on the stdmod parameters used
#
class quantum (

  $package_name              = $quantum::params::package_name,
  $package_ensure            = 'present',

  $service_name              = $quantum::params::service_name,
  $service_ensure            = 'running',
  $service_enable            = true,

  $config_file_path          = $quantum::params::config_file_path,
  $config_file_replace       = $quantum::params::config_file_replace,
  $config_file_require       = 'Package[quantum]',
  $config_file_notify        = 'Service[quantum]',
  $config_file_source        = undef,
  $config_file_template      = undef,
  $config_file_content       = undef,
  $config_file_options_hash  = undef,

  $config_dir_path           = $quantum::params::config_dir_path,
  $config_dir_source         = undef,
  $config_dir_purge          = false,
  $config_dir_recurse        = true,

  $dependency_class          = undef,
  $my_class                  = undef,

  $monitor_class             = undef,
  $monitor_options_hash      = { } ,

  $firewall_class            = undef,
  $firewall_options_hash     = { } ,

  $scope_hash_filter         = '(uptime.*|timestamp)',

  $tcp_port                  = undef,
  $udp_port                  = undef,

  ) inherits quantum::params {


  # Class variables validation and management

  validate_bool($service_enable)
  validate_bool($config_dir_recurse)
  validate_bool($config_dir_purge)
  if $config_file_options_hash { validate_hash($config_file_options_hash) }
  if $monitor_options_hash { validate_hash($monitor_options_hash) }
  if $firewall_options_hash { validate_hash($firewall_options_hash) }

  $config_file_owner          = $quantum::params::config_file_owner
  $config_file_group          = $quantum::params::config_file_group
  $config_file_mode           = $quantum::params::config_file_mode

  $manage_config_file_content = default_content($config_file_content, $config_file_template)

  $manage_config_file_notify = pickx($config_file_notify)

  if $package_ensure == 'absent' {
    $manage_service_enable = undef
    $manage_service_ensure = stopped
    $config_dir_ensure = absent
    $config_file_ensure = absent
  } else {
    $manage_service_enable = $service_enable
    $manage_service_ensure = $service_ensure
    $config_dir_ensure = directory
    $config_file_ensure = present
  }


  # Resources managed

  if $quantum::package_name {
    package { $quantum::package_name:
      ensure   => $quantum::package_ensure,
    }
  }

  if $quantum::service_name {
    service { $quantum::service_name:
      ensure     => $quantum::manage_service_ensure,
      enable     => $quantum::manage_service_enable,
    }
  }

  if $quantum::config_file_path {
    file { 'quantum.conf':
      ensure  => $quantum::config_file_ensure,
      path    => $quantum::config_file_path,
      mode    => $quantum::config_file_mode,
      owner   => $quantum::config_file_owner,
      group   => $quantum::config_file_group,
      source  => $quantum::config_file_source,
      content => $quantum::manage_config_file_content,
      notify  => $quantum::manage_config_file_notify,
      require => $quantum::config_file_require,
    }
  }

  if $quantum::config_dir_source {
    file { 'quantum.dir':
      ensure  => $quantum::config_dir_ensure,
      path    => $quantum::config_dir_path,
      source  => $quantum::config_dir_source,
      recurse => $quantum::config_dir_recurse,
      purge   => $quantum::config_dir_purge,
      force   => $quantum::config_dir_purge,
      notify  => $quantum::config_file_notify,
      require => $quantum::config_file_require,
    }
  }


  # Extra classes

  if $quantum::dependency_class {
    include $quantum::dependency_class
  }

  if $quantum::my_class {
    include $quantum::my_class
  }

  if $quantum::monitor_class {
    class { $quantum::monitor_class:
      options_hash => $quantum::monitor_options_hash,
      scope_hash   => {}, # TODO: Find a good way to inject class' scope
    }
  }

  if $quantum::firewall_class {
    class { $quantum::firewall_class:
      options_hash => $quantum::firewall_options_hash,
      scope_hash   => {},
    }
  }

}

