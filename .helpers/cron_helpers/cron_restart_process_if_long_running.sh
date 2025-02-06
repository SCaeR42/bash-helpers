#!/bin/bash

. /opt/.helpers/restart_process_if_long_running.sh

restart_process_if_long_running "mysqld" "mysqld" 86400
restart_process_if_long_running "systemd-journald" "systemd-journald" 86400
restart_process_if_long_running "systemd-resolved" "systemd-resolved" 86400
restart_process_if_long_running "accounts-daemon" "accounts-daemon" 86400
restart_process_if_long_running "8.2/fpm" "php8.2-fpm" 86400

