#!/usr/bin/env sh
#
# Mostra os logins e nomes de usuários do sistema, lendo do arquivo /etc/passwd
#
# Baseado no livro Shell Script Professional - Aurélio Marinho Jargas
#
# versão 3
#

MENSAGEM_DE_USO="
Uso: $0 [-h | -V]

  -h    Mostra esta dela de ajuda
  -V    Mostra a versão
"

# -----------------------------------------------------
# Tratamento das opções de linha de comando usando o if
# -----------------------------------------------------
#if test "$1" = "-h"
#then
#    echo "$MENSAGEM_DE_USO"
#    exit 0
#elif test "$1" = "-V"
#then
#    echo "$0 Versão 3"
#    exit 0
#fi


# Tratamento das opções de linha de comando.
case "$1" in
    -h) echo "$MENSAGEM_DE_USO" ; exit 0 ;;
    -V) echo "$0 Versão 3" ; exit 0 ;;
     *) echo "Opção inválida: $1" ; exit 1;;
esac


## Processamento
cut -d : -f 1,5 /etc/passwd | tr : \\t

