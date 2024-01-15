#!/bin/bash

clear
echo "*****************INÍCIO DA SIMULAÇÃO DO EXERCÍCIO DE CONVERSAS NO FREECHAINS*******************************"
sleep 5

echo -e "\033[0;31m PARTE 1 - Criação de pastas dos usuarios, inicio de hosts locais, geração e guarda de chaves publicas e privadas\033[0m"

sleep 3

# criação de 5 peers iniciais
for i in 1 2 3 4 5

do
	mkdir user$i
	sleep 1
	freechains-host --port=833$i start /tmp/freechains/user$i/ &
	sleep 1
	freechains --host=localhost:833$i keys pubpvt "Minha frase-passe $i" > /tmp/freechains/chaves$i.txt
	sleep 1
        read cpub cpvt < /tmp/freechains/chaves$i.txt
        echo $cpub > /tmp/freechains/user$i/cpub$i.txt
        echo $cpvt > /tmp/freechains/user$i/cpvt$i.txt
        #exibição das chaves para fins de conferência da simulação
        echo -e "\\033[0;33m Criação do user$i com cpub $cpub e cpvt $cpvt \\033[0m"
done

sleep 5

clear

echo "**********************INÍCIO DE UM NOVO FÓRUM******************************"
sleep 3

echo -e "\033[0;31m PARTE 2 - Criação do chat e a primeira mensagem\033[0m"
sleep 3

# Coletando as chaves do peer 1 
cpio=$(sed -n '1p' /tmp/freechains/user1/cpub1.txt)
cpiopvt=$(cat /tmp/freechains/user1/cpvt1.txt)

echo -e "\\033[0;33m Comando de criação do chat e guarda do Hash da Sala \\033[0m"
freechains --host=localhost:8331 chains join '#sala_de_estudos_1' "$cpio" > hsala.txt
sleep 1

echo -e "\\033[0;33m Criando a primeira mensagem através da leitura do texto de um arquivo \\033[0m"
# coletando a primeira linha do arquivo de bate-papo
linha=$(sed -n '1p' /tmp/freechains/conversa.txt)
# armazenamento do hash do envio da primeira mensagem ao chat
freechains --host=localhost:8331 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo $cpiopvt) > hpost1.txt
sleep 1

echo -e "\\033[0;33m Hash do Bloco Genesis \\033[0m"
#conferindo genesis
freechains --port=8331 chain '#sala_de_estudos_1' genesis
# echo $cpiopvt

sleep 5

clear 
echo -e "\033[0;31m PARTE 3 - Inclusão de outros participantes e repasse da primeira mensagem\033[0m"
sleep 3

#cpio=$(sed -n '1p' /tmp/freechains/user1/cpub1.txt)
cpiopub=$(sed -n '1p' /tmp/freechains/user1/cpub1.txt)

for j in 2 3 4 5

do
#	freechains --host=localhost:833$j chains join '#sala_de_estudos_1' $cpiopub
	freechains --host=localhost:833$j chains join '#sala_de_estudos_1' $cpiopub 
	echo -e "\\033[0;33m Usuário user$j entrou no chat público \\033[0m"
	sleep 1
	freechains --host=localhost:833$j peer localhost:8331 recv '#sala_de_estudos_1'
	echo -e "\\033[0;33m Usuário user$j recebeu chat \\033[0m"
	
done

sleep 5
clear


clear
echo -e "\033[0;31m ***** 1o ACERTO DO RELÓGIO DOS HOSTS - DATA ATUAL \033[0m"
listacpvt=()
i=1
data=$(date +%Y-%m-%d_%H:%M:%S.%3N)
for i in 1 2 3 4 5 
do
	# acerto do relógio dos hosts
	freechains-host --port=833$i now '$(echo $data)'
	echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	echo $data
	#carregamento de chaves privadas em array
	cpvts=$(cat /tmp/freechains/user$i/cpvt$i.txt)
	listacpvt+=("$cpvts")
	sleep 1
	echo "Conferindo Chave Privada"
	echo ${listacpvt[i-1]}
    
done
sleep 5
clear 

echo "*********************** Primeira rodada de mensagens ****************************"
echo -e "\033[0;31m Todos os hosts direcionando a mensagem para host 1 \033[0m"
sleep 3

for l in 2 3 4 5
do
	# variáveis linha recebem texto de uma conversa.txt simulando o bate-papo
	linha=$(sed -n $l'p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:833$l chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[l-1]}) > hpost$l.txt
	freechains --host=localhost:833$l peer localhost:8331 send '#sala_de_estudos_1' 
	echo ">>>>>>>>>> Processo concluído do host $l"
	sleep 2
done

sleep 5
clear
echo -e "\033[0;31m ***** 2o ACERTO DO RELÓGIO DOS HOSTS - PASSAGEM DE 15 DIAS \033[0m"
sleep 3
# acerto dos relógios dos hosts - passagem de 15 dias
data=$(date -d "+15 days" +"%Y-%m-%d %H:%M:%S.%3N")
#d=$(date -d "$data" +%s%N | cut -b1-b13)

for i in 1 2 3 4 5

do
#	estrutura não utilizada setagem do tempo via freechains
#	freechains-host --port=833$i now "$(echo $data)"
	echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	echo $data
#	echo $d
#	estrutura de transformação do timestamp reescrevendo arquivo
	timestamp=$(date -d "$data" +%s%3N) 
	echo $timestamp > /tmp/freechains/user$i/timestamp.txt
	echo "$timestamp" 
	sleep 1
done
sleep 2

echo ">>>>>>>>>> LIKE E CONSENSUS"
sleep 2

#varáveis hpX são ponteiros para último post
hp2=$(sed -n '1p' /tmp/freechains/hpost2.txt)
freechains --host=localhost:8331 chain '#sala_de_estudos_1' like $(echo $hp2) --sign=$(echo ${listacpvt[0]}) > hpost1.txt
echo $hp2
	
freechains --host=localhost:8331 chain '#sala_de_estudos_1' consensus
sleep 3
clear
	
echo "******************* SEGUNDA RODADA DE MENSAGENS ************************"
# segunda rodada de mensagens - mensagens sendo centradas em user2
sleep 1
linha=$(sed -n '6p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt
# comando sleep foi posto para que o simulador em shell possa ter tempo de processar, abrir e fechar arquivos
sleep 1
linha=$(sed -n '7p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8333 peer localhost:8333 recv '#sala_de_estudos_1'
freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[2]}) > hpost3.txt
freechains --host=localhost:8333 peer localhost:8332 send '#sala_de_estudos_1'
# arquivos hpostX foram colocados para armazenar o ultimo hash de atividades
sleep 1
freechains --host=localhost:8334 peer localhost:8332 recv '#sala_de_estudos_1'
linha=$(sed -n '8p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[3]}) > hpost2.txt
freechains --host=localhost:8334 peer localhost:8332 send '#sala_de_estudos_1'
sleep 1
# array listacpvt() armazena as assinaturas para ficar mais enxuto de trabalhar
linha=$(sed -n '9p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt
freechains --host=localhost:8333 peer localhost:8335 send '#sala_de_estudos_1'
sleep 1
linha=$(sed -n '10p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[2]}) > hpost3.txt
freechains --host=localhost:8333 peer localhost:8332 send '#sala_de_estudos_1'
freechains --host=localhost:8332 peer localhost:8331 send '#sala_de_estudos_1'
sleep 5
clear

echo -e "\033[0;31m 3o ACERTO DO RELÓGIO DOS HOSTS - PASSAGEM DE 30 DIAS\033[0m"    
sleep 3    
data=$(date -d "+30 days" +"%Y-%m-%d %H:%M:%S.%3N")
#d=$(date -d "$data" +%s%N | cut -b1-b13)

for i in 1 2 3 4 5

do
#	freechains-host --port=833$i now "$(echo $data)"
	echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	echo $data
#	echo $d
	timestamp=$(date -d "$data" +%s%3N)
	echo $timestamp > /tmp/freechains/user$i/timestamp.txt
	sleep 1
	echo "$timestamp"
	 
done        

for i in 0 1 2 3 4 5 

do

cpub=$(sed -n '1p' /tmp/freechains/user$i/cpub$i.txt)
freechains --host=localhost:833$i chain '#sala_de_estudos_1' reps $cpub

done

sleep 5
clear        
echo "*************** NOVA RODADA DE MENSAGENS *******************"      

#for j in 2 3 4 5
# peer user1 recebe as primeiras mensagens com passagem de tempo
#do

#	freechains --host=localhost:8331 peer localhost:833$j recv '#sala_de_estudos_1'
#	sleep 1

#done

# nessa rodada de mensagens user 2 continua sendo acionado mas já há ramificação
linha=$(sed -n '11p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt
sleep 1
linha=$(sed -n '12p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[2]}) > hpost3.txt
sleep 1
linha=$(sed -n '13p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8331 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[0]}) > hpost1.txt
linha=$(sed -n '14p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8335 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[4]}) > hpost5.txt
freechains --host=localhost:8335 peer localhost:8331 send '#sala_de_estudos_1'
sleep 1
linha=$(sed -n '15p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt
sleep 1
linha=$(sed -n '16p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[3]}) > hpost4.txt
sleep 2
# peer 2 recebe as mensagens de 3 hosts
for i in 3 4 5
do
        freechains --host=localhost:8332 peer localhost:833$i recv '#sala_de_estudos_1'
done
# peer 1 envia os blocos que tem
for i in 2 3 4 
do
        freechains --host=localhost:8331 peer localhost:833$i send '#sala_de_estudos_1'
done
# segundo consensus coletivo depois da passagem de tempo
for i in 1 2 3 4 5

do
	freechains --host=localhost:833$i chain '#sala_de_estudos_1' consensus
	sleep 1
done
sleep 5
clear
echo -e "\033[0;31m 4o ACERTO DO RELÓGIO DOS HOSTS - PASSAGEM DE 45 DIAS \033[0m"
sleep 3
data=$(date -d "+45 days" +"%Y-%m-%d %H:%M:%S.%3N")
#d=$(date -d "$data" +%s%N | cut -b1-b13)

for i in 1 2 3 4 5

do
#	freechains-host --port=833$i now "$(echo $data)"
	echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	echo $data
#	echo $d
	timestamp=$(date -d "$data" +%s%3N)
	sleep 1
	echo $timestamp > /tmp/freechains/user$i/timestamp.txt
	echo "$timestamp"
	sleep 1
done 
  
#while true; do
#    read -p "Deseja continuar executando o script? (y/n) " yn
#    case $yn in
#        [Yy]* ) echo "Continuando a execução do script..."; break;;
#        [Nn]* ) echo "Saindo do script..."; exit;;
#        * ) echo "Por favor, responda com 'y' ou 'n'.";;
#    esac
#done
clear 
#viral
sleep 5
echo "*************************************** VIRAL ***********************************"
hp2=$(sed -n '1p' /tmp/freechains/hpost2.txt)
hp5=$(sed -n '1p' /tmp/freechains/hpost5.txt)
echo -e "\033[0;31mLike do 31\033[0m"
freechains --host=localhost:8331 chain '#sala_de_estudos_1' like $(echo $hp5) --sign=$(echo ${listacpvt[0]})
echo -e "\033[0;31mLike do 33\033[0m" 
freechains --host=localhost:8333 chain '#sala_de_estudos_1' like $(echo $hp2) --sign=$(echo ${listacpvt[2]}) 
echo -e "\033[0;31mLike do 34\033[0m" 
freechains --host=localhost:8334 chain '#sala_de_estudos_1' like $(echo $hp2) --sign=$(echo ${listacpvt[3]})
echo -e "\033[0;31mLike do 35\033[0m" 
freechains --host=localhost:8335 chain '#sala_de_estudos_1' like $(echo $hp2) --sign=$(echo ${listacpvt[4]})
echo $hp2
sleep 3
clear
# novos posts dentro de segmentos
echo "***************************** COMEÇANDO NOVA TROCA DAS MENSAGENS ***************************"
linha=$(sed -n '17p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt
sleep 1
linha=$(sed -n '18p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[2]}) > hpost3.txt
sleep 1
linha=$(sed -n '19p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8331 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[0]}) > hpost1.txt
       
# nova passagem de tempo - 55 dias   
sleep 3
clear
echo -e "\033[0;31m 5o ACERTO DO RELÓGIO DOS HOSTS - PASSAGEM DE 55 DIAS \033[0m"    
data=$(date -d "+55 days" +"%Y-%m-%d %H:%M:%S.%3N")
#d=$(date -d "$data" +%s%N | cut -b1-b13)

for i in 1 2 3 4 5
do
#	freechains-host --port=833$i now "$(echo $data)"
	echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	echo $data
#	echo $d
	timestamp=$(date -d "$data" +%s%3N)
	echo $timestamp > /tmp/freechains/user$i/timestamp.txt
	sleep 1
	echo "$timestamp"
	sleep 1 
done  
sleep 3

echo "***********************TRABALHANDO OS ENVIOS E RECEBIMENTOS ***************************"
freechains --host=localhost:8332 peer localhost:8333 send '#sala_de_estudos_1'
freechains --host=localhost:8333 peer localhost:8334 send '#sala_de_estudos_1'
freechains --host=localhost:8334 peer localhost:8331 send '#sala_de_estudos_1'
#	freechains --host=localhost:8334 peer localhost:8333 send '#sala_de_estudos_1'
sleep 2
echo "***********************MAIS MENSAGENS**********************************************"
sleep 3
linha=$(sed -n '20p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[2]}) > hpost3.txt
linha=$(sed -n '21p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8335 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[4]}) > hpost5.txt    
sleep 1
linha=$(sed -n '22p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt
sleep 1
linha=$(sed -n '16p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[3]}) > hpost4.txt
sleep 1
clear
echo -e "\033[0;31m 6o ACERTO DO RELÓGIO DOS HOSTS - PASSAGEM DE 75 DIAS \033[0m"   
sleep 3
data=$(date -d "+75 days" +"%Y-%m-%d %H:%M:%S.%3N")
#d=$(date -d "$data" +%s%N | cut -b1-b13)

for i in 1 2 3 4 5
do
#	freechains-host --port=833$i now "$(echo $data)"
	echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	echo $data
#	echo $d
	timestamp=$(date -d "$data" +%s%3N)
	echo $timestamp > /tmp/freechains/user$i/timestamp.txt
	echo "$timestamp" 
	sleep 1
done   

sleep 5
# novo consensus após passagem de tempo
for i in 1 2 3 4 5
do
	freechains --host=localhost:833$i chain '#sala_de_estudos_1' consensus
	sleep 1
done

hp2=$(sed -n '1p' /tmp/freechains/hpost2.txt)
hp1=$(sed -n '1p' /tmp/freechains/hpost1.txt)
hp4=$(sed -n '1p' /tmp/freechains/hpost4.txt)
#	echo -e "\033[0;31mLike do 31\033[0m"
#	freechains --host=localhost:8331 chain '#sala_de_estudos_1' like $(echo $hp2) --sign=$(echo ${listacpvt[0]})
echo -e "\033[0;31m Like do User 3 \033[0m" 
freechains --host=localhost:8333 chain '#sala_de_estudos_1' like $(echo $hp4) --sign=$(echo ${listacpvt[2]}) 
echo -e "\033[0;31m Like do User 4 \033[0m" 
freechains --host=localhost:8334 chain '#sala_de_estudos_1' like $(echo $hp1) --sign=$(echo ${listacpvt[3]})
#	echo -e "\033[0;31mLike do 35\033[0m" 
#	freechains --host=localhost:8335 chain '#sala_de_estudos_1' like $(echo $hp2) --sign=$(echo ${listacpvt[4]})
#	echo $hp2

clear
echo "**********************USER1 RECEBE CHAT E OPERAÇÕES NEWBIE ******************************"
sleep 5
#for i in 2 3 4 

#do

        freechains --host=localhost:8331 peer localhost:8332 recv '#sala_de_estudos_1'

#done


# entrada do peer 0 no chat
echo -e "\033[0;31m ENTRADA DO NEWBIE \033[0m"
mkdir user
sleep 2
freechains-host --port=8330 start /tmp/freechains/user/ &
sleep 1
freechains --host=localhost:8330 keys pubpvt "Minha frase-passe 0" > /tmp/freechains/chaves.txt
read cpubnb cpvtnb < /tmp/freechains/chaves.txt
echo $cpubnb > /tmp/freechains/user/cpub.txt
echo $cpvtnb > /tmp/freechains/user/cpvt.txt
echo $timestamp > /tmp/freechains/user/timestamp.txt
cpio=$(sed -n '1p' /tmp/freechains/user1/cpub1.txt)
freechains --host=localhost:8330 chains join '#sala_de_estudos_1' $cpio
echo " >>>> Um novo usuário entrou no chat"
sleep 1
freechains --host=localhost:8330 peer localhost:8331 recv '#sala_de_estudos_1'
linha=$(sed -n '23p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt
sleep 1
linha=$(sed -n '24p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[2]}) > hpost3.txt
sleep 1
#freechains --host=localhost:8333 peer localhost:8334 send '#sala_de_estudos_1'
linha=$(sed -n '25p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[3]}) > hpost4.txt
sleep 1
linha=$(sed -n '26p' /tmp/freechains/conversa.txt)
freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=$(echo ${listacpvt[1]}) > hpost2.txt

clear


for i in 0 1 2 3 4 5 
do
	freechains --host=localhost:833$i chain '#sala_de_estudos_1' consensus
	sleep 1
done

# passagem de 90 dias
echo -e "\033[0;31m 6o ACERTO DO RELÓGIO DOS HOSTS - PASSAGEM DE 90 DIAS\033[0m"

data=$(date -d "+90 days" +"%Y-%m-%d %H:%M:%S.%3N")
#d=$(date -d "$data" +%s%N | cut -b1-b13)

for i in 0 1 2 3 4 5 
do
#	freechains-host --port=833$i now "$(echo $data)"
	echo $data
#	echo $d
	echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	timestamp=$(date -d "$data" +%s%3N)
	echo $timestamp > /tmp/freechains/user$i/timestamp.txt
	echo "$timestamp" 
	sleep 1
done 

freechains --host=localhost:8330 chain '#sala_de_estudos_1' post inline "não gosto de matemática" --sign=$(echo $cpvtnb) > hpost.txt
freechains --host=localhost:8330 chain '#sala_de_estudos_1' consensus
freechains --host=localhost:8330 peer localhost:8331 send '#sala_de_estudos_1'

# passagem dos 95 dias
echo -e "\033[0;31 7o ACERTO DO RELÓGIO DOS HOSTS - PASSAGEM DE 95 DIAS\033[0m"	
data=$(date -d "+95 days" +"%Y-%m-%d %H:%M:%S.%3N")
#d=$(date -d "$data" +%s%N | cut -b1-b13)

for i in 1 2 3 4 5 
do
#	freechains-host --port=833$i now "$(echo $data)"
	echo $data
#	echo $d
        echo ">>>>>>> Exibindo Data e Timestamp do Host$i <<<<<<<<"
	timestamp=$(date -d "$data" +%s%3N)
	echo $timestamp > /tmp/freechains/user$i/timestamp.txt
	echo "$timestamp" 
done 
echo $timestamp > /tmp/freechains/user/timestamp.txt

echo -e "\033[0;31m DISLIKE \033[0m"
	hp0=$(sed -n '1p' /tmp/freechains/hpost.txt)
	freechains --host=localhost:8331 chain '#sala_de_estudos_1' dislike $(echo $hp0) --sign=$(echo ${listacpvt[0]})


echo -e "\033[0;31m CONSENSUS \033[0m"
for i in 0 1 2 3 4 5 

do
	freechains --host=localhost:833$i chain '#sala_de_estudos_1' consensus
	sleep 1
done
sleep 2


freechains --host=localhost:8333 peer localhost:8335 send '#sala_de_estudos_1'
clear
echo -e "\033[0;31m BLOCOS BLOQUEADOS \033[0m"
sleep 2

for i in 0 1 2 3 4 5 

do

freechains --host=localhost:833$i chain '#sala_de_estudos_1' heads

done
sleep 2
echo -e "\033[0;31m REPUTAÇÃO \033[0m"
sleep 2

cpub=$(sed -n '1p' /tmp/freechains/user/cpub.txt)
freechains --host=localhost:8330 chain '#sala_de_estudos_1' reps $cpub

for i in 1 2 3 4 5 

do

cpub=$(sed -n '1p' /tmp/freechains/user$i/cpub$i.txt)
freechains --host=localhost:833$i chain '#sala_de_estudos_1' reps $cpub

done

	








