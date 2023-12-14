#!/bin/bash


echo -e "\033[0;31mCriação do chat e a primeira mensagem\033[0m"

cpio=$(sed -n '1p' /tmp/freechains/user1/cpub1.txt)


freechains --host=localhost:8331 chains join '#sala_de_estudos_1' "$cpio" > hsala.txt
sleep 2

linha=$(sed -n '1p' /tmp/freechains/conversa.txt)
#nessas linhas abaixo eu tentei fazer com que a assinatura recebesse o conteúdo da variavel, mas dá os mais diversos problemas, tanto de java quanto de recusa do que foi passado
#cpvt=$(</home/cesar/freechains/user1/cpvt1.txt)
#freechains --host=localhost:8331 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(cat $cpvt)

freechains --host=localhost:8331 chain '#sala_de_estudos_1' post inline "$linha" --sign=FF8B431553239A5DE4617B959E225DBAA60F8D4B76FBBD073B5BC02C38EBEA3193C400CE198E23F11CE2CA67701EDD40EC15BBA7C7297DD475171E6E4214A331

sleep 2

freechains --port=8331 chain '#sala_de_estudos_1' genesis
