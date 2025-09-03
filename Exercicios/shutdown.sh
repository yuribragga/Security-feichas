#!/bin/bash

LOGFILE="/var/log/syslog"


echo "Eventos de desligamento (shutdown) e reinicialização (reboot) do sistema:"
echo "----------------------------------------------------------------------"

grep -Ei 'shutdown|reboot|systemd-shutdown|systemd-reboot' "$LOGFILE" | while read -r line; do

    echo "$line"
done
