#!/bin/bash

# Este script rastreia o uso do comando 'su' analisando o log de autenticação.

echo "Rastreamento do Uso do Comando 'su'"
echo "------------------------------------------------------------------"
echo "Data         Hora       Origem          ->  Destino"
echo "------------------------------------------------------------------"

# Filtra as linhas que indicam uma sessão 'su' foi aberta.
# Usa 'awk' para encontrar as palavras-chave 'user' e 'by' e extrair os nomes de usuário correspondentes.
# Em seguida, formata e imprime a data, hora, usuário de origem e usuário de destino.
grep "su:.*session opened for user" /var/log/auth.log | \
    awk '{
        for(i=1; i<=NF; ++i) {
            if ($i == "user") target=$(i+1);
            if ($i == "by") source=$(i+1);
        }
        # Remove o "(uid=...)" do final do nome do usuário de origem
        sub(/\(uid=.*/, "", source);
        
        printf "%-6s %-3s %-10s %-15s ->  %s\n", $1, $2, $3, source, target
    }'

echo "------------------------------------------------------------------"

# para executar
# chmod +x track_su.sh
# ./track_su.sh