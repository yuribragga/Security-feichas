#!/bin/bash

# Este script analisa o log de autenticação para encontrar logins bem-sucedidos
# e exibe a data, hora e o nome do usuário.

echo "Relatório de Logins Bem-Sucedidos PAM"
echo "-------------------------------------------------"
echo "Data         Hora       Usuário"
echo "-------------------------------------------------"

# Procura por "Accepted password for" no /var/log/auth.log,
# e usa o awk para formatar e imprimir os campos desejados:
# $1, $2: Mês e Dia
# $3: Hora
# $9: Nome de usuário
grep "session opened for user" /var/log/auth.log | \
    awk '{printf "%-6s %-3s %-10s %-15s\n", $1, $2, $3, $9}'

echo "-------------------------------------------------"

# SSHD
echo "Relatório de Logins Bem-Sucedidos SSHD"
echo "-------------------------------------------------"
echo "Data         Hora       Usuário"
echo "-------------------------------------------------"

# Procura por "Accepted password for" no /var/log/auth.log,
# e usa o awk para formatar e imprimir os campos desejados:
# $1, $2: Mês e Dia
# $3: Hora
# $9: Nome de usuário
grep "Accepted password for" /var/log/auth.log | \
    awk '{printf "%-6s %-3s %-10s %-15s\n", $1, $2, $3, $9}'

echo "-------------------------------------------------"

# para executar
# chmod +x sucessful_logins.sh
# ./sucessful_logins.sh