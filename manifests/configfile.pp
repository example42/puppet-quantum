#
# = Define: quantum::configfile
#
# The define manages quantum configfile
#
#
# == Parameters
#
# [*ensure*]
#   String. Default: present
#   Manages configfile presence. Possible values:
#   * 'present' - Install package, ensure files are present.
#   * 'absent' - Stop service and remove package and managed files
#
# [*template*]
#   String. Default: Provided by the module.
#   Sets the path of a custom template to use as content of configfile
#   If defined, configfile file has: content => content("$template")
#   Example: template => 'site/configfile.conf.erb',
#
# [*options*]
#   Hash. Default undef. Needs: 'template'.
#   An hash of custom options to be used in templates to manage any key pairs of
#   arbitrary settings.
#
define quantum::configfile (
  $template ,
  $ensure   = present,
  $options  = '' ,
  $ensure  = present ) {

  include quantum

  file { "quantum_configfile_${name}":
    ensure  => $ensure,
    path    => "${quantum::config_dir}/${name}",
    mode    => $quantum::config_file_mode,
    owner   => $quantum::config_file_owner,
    group   => $quantum::config_file_group,
    require => Package[$quantum::package],
    notify  => $quantum::manage_registry_service_autorestart,
    content => template($template),
    replace => $quantum::manage_file_replace,
    audit   => $quantum::manage_audit,
    noop    => $quantum::bool_noops,
  }

}
