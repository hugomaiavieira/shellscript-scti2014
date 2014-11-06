#!/usr/bin/env sh
#
# Um breve exemplo do uso de funções e do comando read.
#

pedir_nome () {
  echo -n "Digite: "
  read NOME
}

pedir_nome

echo "Seu nome é $NOME"

