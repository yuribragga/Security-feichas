#!/bin/bash

# Este script identifica logins rejeitados por motivos que não sejam senha incorreta,
# como usuários inválidos ou outras falhas de autenticação.

echo "Relatório de Outros Logins Rejeitados"
echo "--------------------------------------------------------------------------"
echo "Data/Hora                 Detalhes do Evento"
echo "--------------------------------------------------------------------------"

# 1. Usa 'grep -E' para encontrar linhas que contenham "Failed" ou "Invalid user".
#    Isso captura uma ampla gama de falhas.
# 2. Usa 'grep -v' para excluir as linhas que são especificamente sobre "Failed password".
#    O que sobra são as falhas por outros motivos.
# 3. Usa 'awk' para formatar a saída, imprimindo a data, hora e o restante da mensagem de log.
grep -E "Failed|Invalid user" /var/log/auth.log | grep -v "Failed password" | \
    awk '{
        # Concatena os 3 primeiros campos (Mês, Dia, Hora)
        timestamp = $1 " " $2 " " $3;
        
        # Inicia a mensagem a partir do 4º campo
        message = "";
        for (i = 4; i <= NF; i++) {
            message = message $i " ";
        }
        
        # Imprime a data/hora e a mensagem formatada
        printf "%-25s %s\n", timestamp, message;
    }'

echo "--------------------------------------------------------------------------"