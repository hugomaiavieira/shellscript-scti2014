#!/usr/bin/env sh
#
# Mostra os logins e nomes de usuários do sistema, lendo do arquivo /etc/passwd
#
# Baseado no livro Shell Script Professional - Aurélio Marinho Jargas
#
# versão 4
#

MENSAGEM_DE_USO="
Uso: $(basename "$0") [-h | -V]

  -h, --help      Mostra esta dela de ajuda
  -V, --version   Mostra a versão
"

# Tratamento das opções de linha de comando.
case "$1" in

    -h | --help)
        echo "$MENSAGEM_DE_USO"
        exit 0
    ;;

    -V | --version)
        echo -n "$(basename "$0")"
        # extrai a verão do cabeçalho do programa
        grep '^# versão' "$0" | tr -d \#
        exit 0
    ;;

    *)
        if [ -n "$1" ]
        then
            echo "Opção inválida: $1"
            exit 1
        fi
    ;;
esac

# Processamento
cut -d : -f 1,5 /etc/passwd | tr : \\t

