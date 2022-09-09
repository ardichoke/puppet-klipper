# @summary Perform baseline install of Klipper
#
# @api private
#
class klipper::install {
  $_packages = [
    'git',
    'virtualenv',
    'python-dev',
    'libffi-dev',
    'build-essential',
    'libncurses-dev',
    'libusb-dev',
    'avrdude',
    'gcc-avr',
    'binutils-avr',
    'avr-libc',
    'stm32flash',
    'dfu-util',
    'libnewlib-arm-none-eabi',
    'gcc-arm-none-eabi',
    'binutils-arm-none-eabi',
    'libusb-1.0',
  ]

  ensure_packages($_packages)

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  vcsrepo { $klipper::src_path:
    ensure   => $klipper::version,
    provider => 'git',
    source   => 'https://github.com/Klipper3d/klipper',
    user     => $klipper::user,
    require  => Package['git'],
  }
  -> exec { 'Initialize Klipper virtualenv':
    command => "virtualenv -p python2 ${klipper::python_dir}",
    creates => $klipper::python_dir,
    user    => $klipper::user,
  }
  ~> exec { 'Install Klipper python modules':
    command     => "${klipper::python_dir}/bin/pip install -r ${klipper::python_dir}/scripts/klippy-requirements.txt",
    refreshonly => true,
    subscribe   => Vcsrepo[$klipper::src_path],
    user        => $klipper::user,
  }

  file { $klipper::log_path:
    ensure => directory,
    owner  => $klipper::user,
    mode   => '0755',
  }
}
