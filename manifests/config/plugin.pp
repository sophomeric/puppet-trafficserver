#   Copyright 2013 Brainsware
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# This type handles adding values to plugins.config
define trafficserver::config::plugin (
  $plugin    = $title,
  $extension = $trafficserver::params::plugin_extension,
  $args      = [],
) {
  include 'trafficserver'

  $configfile = "${::trafficserver::sysconfdir}/plugin.config"

  $lens    = 'Trafficserver_plugin.lns'
  $context = "/files${configfile}"
  $incl    = $configfile

  augeas { "${lens}_${title}":
    lens    => $lens,
    context => $context,
    incl    => $incl,
    changes => template('trafficserver/plugin.config.erb'),
    notify  => Exec[trafficserver-config-reload],
    require => Package[trafficserver],
  }
}
