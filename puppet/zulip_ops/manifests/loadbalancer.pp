class zulip_ops::loadbalancer {
  include zulip_ops::base
  include zulip::nginx
  include zulip::camo

  file { "/etc/nginx/sites-available/loadbalancer":
    require => Package["nginx-full"],
    ensure => file,
    owner  => "root",
    group  => "root",
    mode => 644,
    source => "puppet:///modules/zulip_ops/nginx/sites-available/loadbalancer",
    notify => Service["nginx"],
  }

  file { "/etc/motd":
    ensure => file,
    owner  => "root",
    group  => "root",
    mode => 644,
    source => "puppet:///modules/zulip_ops/motd.lb0",
  }

  file { '/etc/nginx/sites-enabled/loadbalancer':
    require => Package["nginx-full"],
    ensure => 'link',
    target => '/etc/nginx/sites-available/loadbalancer',
    notify => Service["nginx"],
  }

  file { '/etc/log2zulip.conf':
    ensure     => file,
    owner      => "zulip",
    group      => "zulip",
    mode       => 644,
    source     => 'puppet:///modules/zulip_ops/log2zulip.conf',
  }

  file { '/etc/cron.d/log2zulip':
    ensure     => file,
    owner      => "root",
    group      => "root",
    mode       => 644,
    source     => 'puppet:///modules/zulip_ops/cron.d/log2zulip',
  }

  file { '/etc/log2zulip.zuliprc':
    ensure     => file,
    owner      => "zulip",
    group      => "zulip",
    mode       => 600,
    source     => 'puppet:///modules/zulip_ops/log2zulip.zuliprc',
  }
}
