# @summary
#
# Installs and manages klipper
#
# @example
#   include klipper
#
# @param src_path The filesystem path to clone the klipper source code to
# @param version The version of klipper to install
# @param user The account to run klipper under
# @param python_dir The path to place the klipper python virtualenv
# @param config_dir The path to place klipper config files
# @param log_path Where to store the klipper logs
#
class klipper (
  String $version = 'present',
  String $user = 'pi',
  Stdlib::Absolutepath $src_path = "/home/${klipper::user}/klipper",
  Stdlib::Absolutepath $python_dir = "/home/${klipper::user}/klippy-env",
  Stdlib::Absolutepath $config_dir = "/home/${klipper::user}/klipper_config",
  Stdlib::Absolutepath $log_path = "/home/${klipper::user}/klipper_logs",
) {
  contain klipper::install
  contain klipper::configure
  contain klipper::service

  Class['klipper::install']
  -> Class['klipper::configure']
  -> Class['klipper::service']
}
