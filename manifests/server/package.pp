# Class: mcollective::server::package
#
#   This class installs the MCollective server package and all dependencies.
#
# Parameters:
#
#  [*version*]  - The version of the MCollective package(s) to be installed.
#
#  -The below two variables are optional and for OS X installs only-
# [*$mc_pkgname_base*]   - The name of the OS X mcollective base package.
# [*$mc_pkgname_common*] - The name of the OS X mcollective common package.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mcollective::server::package(
  $version,
  $mc_package_path    = $mcollective::params::mc_package_path,
  $mc_pkgname_base    = $mcollective::params::mc_pkgname_base,
  $mc_pkgname_common  = $mcollective::params::mc_pkgname_common
) inherits mcollective::params {

  # The relationship to this class is required because other classes, e.g.
  # Class['mcollective::config'] requires the mcollective::server:package class.
  case $operatingsystem {
    debian,ubuntu: {
      class { 'mcollective::server::package::debian':
        version => $version,
        before  => Class['mcollective::server::package'],
      }
    }
    rhel,centos,oel: {
      class { 'mcollective::server::package::redhat':
        version => $version,
        before  => Class['mcollective::server::package'],
      }
    }
    darwin: {
      class { 'mcollective::server::package::osx':
        version         => $version,
        path            => $mc_package_path,
        pkgname_base    => $mc_pkgname_base,
        pkgname_common  => $mc_pkgname_common,
        before          => Class['mcollective::server::package'],
      }
    }
  }

}

