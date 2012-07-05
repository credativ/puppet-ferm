class ferm (
    $ensure         = params_lookup('ensure'),
    $ensure_running = params_lookup('ensure_running'),
    $ensure_enabled = params_lookup('ensure_enabled'),
    $disabled_hosts = params_lookup('disabled_hosts')
) inherits ferm::params {

    package { 'ferm':
        ensure => $ensure
    }

    file { '/etc/ferm/ferm.conf':
        source  => 'puppet:///modules/ferm/ferm.conf',
        ensure  => present,
        mode    => '0644',
        owner   => 'root',
        group   => 'root',
        require => Package['ferm'],
        notify  => Service['ferm']
    }

    service { 'ferm':
        ensure      => $ensure_running,
        enable      => $ensure_enabled,
        hasrestart  => true,
        hasstatus   => false,
        require     => Package['ferm']
    }

    if $::hostname in $disabled_hosts {
        Service <| title == 'gld' |> {
            ensure  => 'stopped',
            enabled => false,
        }
    }
}
