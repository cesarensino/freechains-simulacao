#!/bin/bash


echo -e "\033[0;31mEnvio de mensagens dos outros hosts\033[0m"
i=1
data=$(date +%Y-%m-%d_%H:%M:%S.%3N)
for d in 1 2 3 4 5 
do
	freechains-host --port=833$d now '(cat $data)'

done
#aqui o ideal é fazer um for ou criar uma função pra toda vez que precisar chamar função parecida o simulador poderia faze-lo, alem de ler o arquivo de conversas automaticamente, e novamente, só precisei repetir linhas praticamente por conta da assinatura
#for l in 2 3 4 5

#do

#	linha=$(sed -n $l'p' /home/cesar/freechains/conversa.txt)
        linha=$(sed -n '2p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=74BD30AF8EE746886A58FFB8FC410E12928D3B127CE2829527B32E18DEA5D190CC6CD2DFA497766D081B953D5BBB5DE82C45F1534E97E079D98A79CB9429F26D
	sleep 2
	linha=$(sed -n '3p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=79943C36DC70950519A87029E729D715738CFA29DA6FC5A2D05BF73376F108A0D1B0F7EB8D47D3AF09580004A47DAF84F291074534890E39A6282E5A4834FAA7 
	sleep 2
	linha=$(sed -n '4p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=A42C9A103A3E0DFD44DF8A83BC745BD69DEB47F69912424650B546D3DFC1C36806855E69A5E1EBB527E7EADEAA6676429317605EA3D7C9F02AF442E5E3298C9B
	sleep 2
	linha=$(sed -n '5p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8335 chain '#sala_de_estudos_1' post inline "$linha" --sign=93EBE5493F9C8D5141C6D32D04015921BBD00A44127C1694A8733D05BAE201DBE4A9DD5C519E128F9039A1CD5C8E0C96C8F6D8DD1FF005DC56B339E2DD7C5F61

	
	for l in 2 3 4 5
do
	
	freechains --host=localhost:833$i peer localhost:833$l recv '#sala_de_estudos_1' 

done


#done
