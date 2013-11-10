# = Class: quantum::example42
#
# Example42 puppi additions. To add them set:
#   my_class => 'quantum::example42'
#
class quantum::example42 {

  puppi::info::module { 'quantum':
    packagename => $quantum::package_name,
    servicename => $quantum::service_name,
    processname => 'quantum',
    configfile  => $quantum::config_file_path,
    configdir   => $quantum::config_dir_path,
    pidfile     => '/var/run/quantum.pid',
    datadir     => '',
    logdir      => '/var/log/quantum',
    protocol    => 'tcp',
    port        => '5000',
    description => 'What Puppet knows about quantum' ,
    # run         => 'quantum -V###',
  }

  puppi::log { 'quantum':
    description => 'Logs of quantum',
    log         => [ '/var/log/quantum/quantum.log' , '/var/log/quantum/quantum-manage.log' ],
  }

}
