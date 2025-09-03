#!/bin/bash

echo "Tentativas de Login Falhas no SUDO:"
echo "---------------------------"
echo "Contagem   Usuário"
echo "---------------------------"


## Versão para PAM
# filtra o arquivo var/log/auth.log e extrai apenas as linhas que contêm a frase "authentication failure"
grep "authentication failure" /var/log/auth.log | \
   # extrai o nome de usuário da linha correspondente
    grep -oP 'user=\K\S+' | \
   # ordena os nomes de usuário
    sort | \
    # uniq remove linhas duplicadas e -c conta as ocorrências
    uniq -c | \
    # -n  ordena numericamente e -r reverte a ordem(do maior para o menor)
    sort -nr | \
    # processar o texto por linha
    awk '{printf "%-10s %s\n", $1, $2}'

echo "---------------------------"


# Versão para SSHD
echo "---------------------------"
echo "Tentativas de Login Falhas por SSHD:"
echo "---------------------------"
echo "Contagem   Usuário"
echo "---------------------------"
grep "Failed password for" /var/log/auth.log | \
    grep -oP 'for \K[^ ]+' | \
    sort | \
    uniq -c | \
    sort -nr | \
    awk '{printf "%-10s %s\n", $1, $2}'
echo "---------------------------"
# para executar 
# chmod +x failed_logins.sh
# ./failed_logins.sh