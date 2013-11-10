#quantum

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Resources managed by quantum module](#resources-managed-by-quantum-module)
    * [Setup requirements](#setup-requirements)
    * [Beginning with module quantum](#beginning-with-module-quantum)
4. [Usage](#usage)
5. [Operating Systems Support](#operating-systems-support)
6. [Development](#development)

##Overview

This module installs, manages and configures quantum.

##Module Description

The module is based on **stdmod** naming standards version 0.9.0.

Refer to http://github.com/stdmod/ for complete documentation on the common parameters.

For a fully puppetized OpenStack implementation you'd better use the [official StackForge modules](https://github.com/stackforge/puppet-openstack).
This module is intended to be a quick replacement for scenarios where you need to manage configurations based on plain templates or where you have to puppettize an existing OpenStack setup.

##Setup

###Resources managed by quantum module
* This module installs the quantum package
* Enables the quantum service
* Can manage all the configuration files (by default no file is changed)

###Setup Requirements
* PuppetLabs stdlib module
* StdMod stdmod module
* Puppet version >= 2.7.x
* Facter version >= 1.6.2

###Beginning with module quantum

To install the package provided by the module just include it:

        include quantum

The main class arguments can be provided either via Hiera (from Puppet 3.x) or direct parameters:

        class { 'quantum':
          parameter => value,
        }

The module provides also a generic define to manage any quantum configuration file:

        quantum::conf { 'sample.conf':
          content => '# Test',
        }


##Usage

* A common way to use this module involves the management of the main configuration file via a custom template (provided in a custom site module):

        class { 'quantum':
          config_file_template => 'site/quantum/quantum.conf.erb',
        }

* You can write custom templates that use setting provided but the config_file_options_hash paramenter

        class { 'quantum':
          config_file_template      => 'site/quantum/quantum.conf.erb',
          config_file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }

* Use custom source (here an array) for main configuration file. Note that template and source arguments are alternative.

        class { 'quantum':
          config_file_source => [ "puppet:///modules/site/quantum/quantum.conf-${hostname}" ,
                                  "puppet:///modules/site/quantum/quantum.conf" ],
        }


* Use custom source directory for the whole configuration directory, where present.

        class { 'quantum':
          config_dir_source  => 'puppet:///modules/site/quantum/conf/',
        }

* Use custom source directory for the whole configuration directory and purge all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it is desctructive and may remove files.

        class { 'quantum':
          config_dir_source => 'puppet:///modules/site/quantum/conf/',
          config_dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'quantum':
          config_dir_source    => 'puppet:///modules/site/quantum/conf/',
          config_dir_recursion => false, # Default: true.
        }


* Use the additional example42 subclass for puppi extensions

        class { 'quantum':
          my_class => 'quantum::example42'
        }


##Operating Systems Support

This is tested on these OS:
- RedHat osfamily 6
- Ubuntu 12.04


##Development

Pull requests (PR) and bug reports via GitHub are welcomed.

When submitting PR please follow these quidelines:
- Provide puppet-lint compliant code
- If possible provide rspec tests
- Follow the module style and stdmod naming standards

When submitting bug report please include or link:
- The Puppet code that triggers the error
- The output of facter on the system where you try it
- All the relevant error logs
- Any other information useful to undestand the context
