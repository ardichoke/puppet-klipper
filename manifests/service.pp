# @summary Manage the klipper service
#
# @api private
#
class klipper::service {
  systemd::unit_file { 'klipper.service':
    content => template('klipper/klipper.service.erb'),
    enable  => true,
    active  => true,
  }
}
