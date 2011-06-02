# Class: mcollective::server::package::osx
#
#   This class installs MCollective dependency packages for OS X.
#
# Parameters:
#
# [*$version*]        - The version of the MCollective package to be installed.
# [*$path*]           - The path to the pkgdmg repository for OS X packages.
# [*$pkgname_base*]   - The name of the mcollective base package.
# [*$pkgname_common*] - The name of the mcollective common package.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mcollective::server::package::osx(
  $version,
  $path,
  $pkgname_base,
  $pkgname_common
) {

  package {'stomp':
    ensure    => present,
    provider  => gem,
  }

  package { $pkgname_base:
    ensure	  => $version,
    source    => "${path}/${pkgname_base}",
    provider  => pkgdmg,
  }
  
  package { $pkgname_common:
    ensure	  => $version,
    source    => "${path}/${pkgname_common}",
    provider  => pkgdmg,
  }

}

