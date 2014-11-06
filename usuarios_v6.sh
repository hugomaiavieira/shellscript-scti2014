#!/usr/bin/env sh
#
# Mostra os logins e nomes de usuários do sistema, lendo do arquivo /etc/passwd
#
# Baseado no livro Shell Script Professional - Aurélio Marinho Jargas
#
# versão 6
#

ordenar=0
inverter=0
delimitar=0
delimitador="\\t"

MENSAGEM_DE_USO="
Uso: $(basename "$0") [OPÇÕES]

OPÇÕES:

  -h, --help                Mostra esta dela de ajuda
  -V, --version             Mostra a versão
  -s, --sort                Ordena a listagem
  -r, --reverse             Inverte a ordem da listagem
  -u, --uppercase           Converte para maiúsculas
  -d, --delimiter DELIM     Usa o DELIM ao invés do TAB como delimitador
"

# Tratamento das opções de linha de comando.
while [ -n "$1" ]
do
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

        -d | --dellimiter)
            delimitar=1
            shift
            delimitador="$1"
        ;;

        -r | --reverse)
            inverter=1
        ;;

        -u | --uppercase)
            maiusculas=1
        ;;

        *)
            if [ -n "$1" ]
            then
                echo "Opção inválida: $1"
                exit 1
            fi
        ;;
    esac

    # faz a fila de parâmetros andar
    shift
done

# extrai a listagem
lista=$(cut -d : -f 1,5 /etc/passwd)

# ordena a listagem se necessário
[ "$ordenar" = 1 ] && lista=$(echo "$lista" | sort)

# inverte a listagem se necessário
[ "$inverter" = 1 ] && lista=$(echo "$lista" | tac)

# converte para maiúsculas se necessário
[ "$maiusculas" = 1 ] && lista=$(echo "$lista" | tr a-z A-Z)

# mostra o resultado para o usuário
echo "$lista" | tr : "$delimitador"

