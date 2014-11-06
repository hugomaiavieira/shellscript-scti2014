#!/usr/bin/env sh
#
# Mostra os logins e nomes de usuários do sistema, lendo do arquivo /etc/passwd
#
# Baseado no livro Shell Script Professional - Aurélio Marinho Jargas
#
# versão 2
#

MENSAGEM_DE_USO="
Uso: $0 [-h]

  -h    Mostra esta tela de ajuda
"

# Tratamento das opções de linha de comando.
if test "$1" = "-h"
then
    echo "$MENSAGEM_DE_USO"
    exit 0 # retorno 0 significa tudo OK
fi

# Processamento
cut -d : -f 1,5 /etc/passwd | tr : \\t

