#!/usr/bin/env sh
#
# Mostra os logins e nomes de usuários do sistema, lendo do arquivo /etc/passwd
#
# Baseado no livro Shell Script Professional - Aurélio Marinho Jargas
#
# versão 5
#

ordenar=0

MENSAGEM_DE_USO="
Uso: $(basename "$0") [OPÇÕES]

OPÇÕES:

  -h, --help        Mostra esta dela de ajuda
  -V, --version     Mostra a versão
  -s, --sort        Ordena a listagem
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

    -s | --sort)
        ordenar=1
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

# -------------------------------------
# Forma simples com repetição de código
# -------------------------------------
#if [ "$ordenar" = 1 ]
#then
#    cut -d : -f 1,5 /etc/passwd | tr : \\t | sort
#else
#    cut -d : -f 1,5 /etc/passwd | tr : \\t
#fi

# extrai a listagem
lista=$(cut -d : -f 1,5 /etc/passwd)

# ordena a listagem se necessário
if [ "$ordenar" = 1 ]
then
    lista=$(echo "$lista" | sort)
fi

# mostra o resultado para o usuário
echo "$lista" | tr : \\t

