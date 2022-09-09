# @summary Handles configuration of klipper
#
# @api private
#
class klipper::configure {
  file { $klipper::config_dir:
    ensure => directory,
    owner  => $klipper::user,
    mode   => '0755',
  }
  file { "${klipper::config_dir}/printer.cfg":
    ensure => file,
    owner  => $klipper::user,
    mode   => '0644',
  }
}
