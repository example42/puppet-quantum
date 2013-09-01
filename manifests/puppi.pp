# Class: quantum::puppi
#
class quantum::puppi {

  # For Puppi 2 (WIP)
  $classvars=get_class_args()
  puppi::ze { 'quantum':
    ensure    => $quantum::manage_file,
    variables => $classvars,
    helper    => $quantum::puppi_helper,
    noop      => $quantum::noops,
  }

  # For Puppi 1
  puppi::info::module { 'quantum':
    packagename => $quantum::package,
    servicename => $quantum::service,
    processname => $quantum::process,
    configfile  => $quantum::config_file,
    configdir   => $quantum::config_dir,
    pidfile     => $quantum::pid_file,
    datadir     => $quantum::data_dir,
    logdir      => $quantum::log_dir,
    protocol    => $quantum::protocol,
    port        => $quantum::port,
    description => 'What Puppet knows about quantum' ,
    # run         => 'quantum -V###',
  }

  puppi::log { 'quantum':
    description => 'Logs of quantum' ,
    log         => $quantum::log_file,
  }

}
