#!/bin/bash

PERIODO=${1:-"1 day ago"}

echo "Serviços que tiveram alteração de status (start/stop) desde $PERIODO:"
echo "--------------------------------------------------------------------"

journalctl --since "$PERIODO" --no-pager | \
grep -Ei 'systemd\[.*\]: (Started|Stopped) ' | \
awk '
{
    date = $1 " " $2 " " $3
    status = ""
    if ($0 ~ /Started/) status = "Started"
    else if ($0 ~ /Stopped/) status = "Stopped"

    pos = index($0, status)
    if (pos > 0) {
        service = substr($0, pos + length(status) + 1)
        split(service, arr, ".")
        service = arr[1]
        gsub(/^ +| +$/, "", service)
    }
    print date " - " service " - " status
}' | sort | uniq
