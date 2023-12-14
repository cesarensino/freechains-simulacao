#!/bin/bash


echo -e "\033[0;31mCriação de pastas dos usuarios, inicio de hosts locais, geração e guarda de chaves publicas e privadas\033[0m"

for i in 1 2 3 4 5

do
	mkdir user$i
	sleep 3
	freechains-host --port=833$i start /tmp/freechains/user$i/ &
	sleep 3
	freechains --host=localhost:833$i keys pubpvt "Minha frase-passe $i" > /tmp/freechains/chaves$i.txt
       read cpub cpvt < /tmp/freechains/chaves$i.txt
       echo $cpub > /tmp/freechains/user$i/cpub$i.txt
       echo $cpvt > /tmp/freechains/user$i/cpvt$i.txt
       echo -e "\\033[0;33m Variáveis do user$i cpub $cpub cpvt $cpvt \\033[0m"
done
