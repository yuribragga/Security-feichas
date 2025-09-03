#!/bin/bash

# Este script audita o uso do comando 'sudo', mostrando quem executou, quando e qual comando.

echo "Auditoria de Uso do Comando 'sudo'"
echo "--------------------------------------------------------------------------------"
echo "Data         Hora       Usuário         Comando Executado"
echo "--------------------------------------------------------------------------------"

# Filtra as linhas de log que contêm execuções de comando via sudo.
# A expressão "sudo:.*COMMAND=" garante que pegamos apenas as linhas de execução de comandos.
# Em seguida, o awk é usado para formatar a saída.
grep "sudo:.*COMMAND=" /var/log/auth.log | \
    awk '{
        # O nome de usuário é o 5º campo na linha de log do sudo
        user = $5;
        
        # Encontra a posição da string "COMMAND="
        cmd_start = index($0, "COMMAND=");
        
        # Extrai a substring que contém o comando, começando 8 caracteres após "COMMAND="
        command = substr($0, cmd_start + 8);
        
        # Imprime os campos formatados
        printf "%-6s %-3s %-10s %-15s %s\n", $1, $2, $3, user, command
    }'

echo "--------------------------------------------------------------------------------"

# para executar
# chmod +x audit_sudo.sh
# ./audit_sudo.sh