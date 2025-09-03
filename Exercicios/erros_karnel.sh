#!/bin/bash

LOGFILE="/var/log/kern.log"

echo "Mensagens do kernel relacionadas a erros, falhas e avisos:"
echo "-----------------------------------------------------------"

grep -Ei 'error|fail|warn|critical|panic' "$LOGFILE"
