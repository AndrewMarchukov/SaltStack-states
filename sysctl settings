kernel.shmmax:
  sysctl.present:
    - value: {{ grains.mem_total * 1024 * 1024 }}

kernel.shmall:
  sysctl.present:
    - value: {{ (grains.mem_total * 1024 * 1024) // 4096 }}

{% for param, value in [('net.core.default_qdisc', 'fq_codel'), ('vm.swappiness', '0'), ('net.ipv4.ip_local_port_range', '1024 65535'), ('net.ipv4.tcp_syncookies', '1'), ('net.ipv4.tcp_max_syn_backlog', '40960'), ('net.ipv4.tcp_synack_retries', '2'), ('net.ipv4.tcp_fin_timeout', '30'), ('net.ipv4.tcp_keepalive_time', '600'), ('net.ipv4.tcp_keepalive_intvl', '10'), ('net.ipv4.tcp_keepalive_probes', '5'), ('net.ipv4.tcp_retries1', '3'), ('net.ipv4.tcp_retries2', '5'), ('net.ipv4.tcp_syn_retries', '4'), ('net.core.netdev_max_backlog', '20000'), ('net.core.somaxconn', '40960'), ('net.ipv4.tcp_max_tw_buckets', '72000'), ('net.ipv4.tcp_slow_start_after_idle', '0'), ('net.ipv4.tcp_congestion_control', 'yeah'), ('net.ipv4.tcp_fastopen', '3'), ('net.core.wmem_max', '16777216'), ('net.core.rmem_max', '16777216'), ('net.ipv4.neigh.default.proxy_qlen', '96'), ('net.unix.max_dgram_qlen', '128'), ('net.ipv4.tcp_rfc1337', '1'), ('fs.aio-max-nr', '33816576'), ('fs.inotify.max_user_watches', '524288'), ('fs.inotify.max_queued_events', '65536'), ('vm.dirty_background_ratio', '15'), ('vm.dirty_ratio', '25'), ('vm.overcommit_memory', '1'), ('net.ipv4.ip_default_ttl', '64'), ('net.ipv4.tcp_tw_recycle', '0'), ('net.ipv4.tcp_tw_reuse', '0')] %}

{{ param }}:
  sysctl.present:
    - value: {{ value }}


{% endfor %}
