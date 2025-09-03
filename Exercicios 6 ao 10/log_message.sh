#!/bin/bash

PERIODO=${1:-"1 day ago"}

echo "Mensagens de log relacionadas a problemas de hardware desde $PERIODO:"
echo "--------------------------------------------------------------------"

journalctl --since "$PERIODO" --no-pager | \
grep -Ei '\b(error|fail(ed|ure)?|warn(ing)?|disk|usb|ata|scsi|device|storage|io error|hardware|timeout|unreachable|corrupt|bad sector|fault|critical|panic)\b'
