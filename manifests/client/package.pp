# Class: mcollective::client::package
#
#   This class installs the MCollective client package and all dependencies.
#
# Parameters:
#
#  [*version*]          - The version of the MCollective package(s) to
#                             be installed.
#
#  -The below two variables are optional and for OS X installs only-
# [*$mc_package_path*]  - The path to the pkgdmg repository for OS X packages.
# [*$pkgname_client*]     - The name of the mcollective client package.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mcollective::client::package(
  $version,
  $pkgname_client   = $mcollective::params::mc_pkgname_client,
  $mc_package_path  = $mcollective::params::mc_package_path,
) {

  case $operatingsystem {
    darwin: {
      package { $pkgname_client:
        ensure	  => $version,
        source    => "${mc_package_path}/${pkgname_client}",
        provider  => pkgdmg,
      }
    }
    default: {
      package { 'mcollective-client':
        ensure	  => $version,
      }
    }
  }

}

