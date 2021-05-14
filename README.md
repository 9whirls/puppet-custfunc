# puppet-custfunc
Custom functions for Puppet

Package resource of Puppet could be used to install applications on Windows nodes. For instance, the sample Puppet code below could install Firefox 88.0.
```
$ff_ver = '88.0'
package { "Mozilla Firefox ${ff_ver} (x64 en-US)":
  ensure          => installed,
  source          => "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${ff_ver}/win64/en-US/Firefox%20Setup%20${ff_ver}.msi",
  install_options => ['/qn']
}
```
According to https://puppet.com/docs/puppet/7.6/resources_package_windows.html, setting ```ensure => latest``` (which requires the upgradeable feature) doesn’t work on Windows, because Windows doesn’t have central package repositories like on most *nix systems.

However, introducing a 3rd party central package system for Windows to solve this problem is too expensive. A more lightweighted solution is to set the package version number (such as $ff_ver in the sample code) programatically. 

This Puppet module contains custom functions for getting the latest version numbers of various applications. To use those custom functions, first add the following codes in your Puppetfile.
```
mod 'puppet-custfunc',
  :git => 'https://github.com/9whirls/puppet-custfunc.git',
  :ref => 'main'
```
And then use the functions in your Puppet code as illustrated below.
```
# Get the latest firefox version
$ff_ver = custfunc::get_firefox_ver()

# Get the latest notepad++ version
$npp_ver = custfunc::get_git_rel('notepad-plus-plus/notepad-plus-plus')

# In case you have to use a token to query github
$osquery_ver = custfunc::get_git_rel_w_token('osquery/osquery', '<your token>')
```
