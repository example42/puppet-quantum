# Class: quantum::params
#
# This class defines default parameters used by the main module class quantum
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to quantum class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class quantum::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'quantum-server',
    default                   => 'openstack-quantum',
  }

  $service = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'quantum',
    default                   => 'openstack-quantum',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'quantum',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'quantum',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/quantum',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/quantum/quantum.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'quantum',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'quantum',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/quantum.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/quantum',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/quantum',
  }

  $log_file = $::operatingsystem ? {
    default => [ '/var/log/quantum/quantum.log' , '/var/log/quantum/quantum-manage.log' ],
  }

  $port = '5000'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}
