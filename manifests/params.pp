class ferm::params {
    $ensure         = present
    $ensure_running = true
    $ensure_enabled = true
    $disabled_hosts = []
    $snat_to        = undef
}

