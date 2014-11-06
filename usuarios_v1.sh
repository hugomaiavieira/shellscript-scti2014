#!/usr/bin/env sh
#
# Mostra os logins e nomes completos de usuários do sistema, lendo do arquivo /etc/passwd
#
# Baseado no livro Shell Script Professional - Aurélio Marinho Jargas
#
# No seu script real, além de colocar o autor, você deve colocar para cada
# versão a data e uma breve descrição das modificações. Nas próximas versões,
# vou colocar apenas o número da versão para facilitar.
#
# versão 1 (09/11/11): Versão inicial
#
# Autor: Hugo Maia Vieira <hugomaiavieira@gmail.com>
#
cut -d : -f 1,5 /etc/passwd | tr : \\t

