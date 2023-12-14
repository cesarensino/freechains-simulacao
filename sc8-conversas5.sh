#!/bin/bash

#newbie,troll

data=$(date -d "+75 days" +"%Y-%m-%d %H:%M:%S.%3N")
for i in 1 2 3 4 5

do

     freechains-host --port=833$i now '(cat $data)'

done

mkdir user6
sleep 2
freechains-host --port=8336 start /tmp/freechains/user6/ &
sleep 2
freechains --host=localhost:8336 keys pubpvt "Minha frase-passe 6" > /tmp/freechains/chaves6.txt
read cpub cpvt < /tmp/freechains/chaves6.txt
echo $cpub > /tmp/freechains/user$i/cpub$i.txt
echo $cpvt > /tmp/freechains/user$i/cpvt$i.txt

cpio=$(sed -n '1p' /tmp/freechains/user1/cpub1.txt)

freechains --host=localhost:8336 chains join '#sala_de_estudos_1' $cpio
sleep 2
freechains --host=localhost:8336 peer localhost:8336 send '#sala_de_estudos_1'


linha=$(sed -n '23p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=74BD30AF8EE746886A58FFB8FC410E12928D3B127CE2829527B32E18DEA5D190CC6CD2DFA497766D081B953D5BBB5DE82C45F1534E97E079D98A79CB9429F26D
	sleep 2

	linha=$(sed -n '24p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=79943C36DC70950519A87029E729D715738CFA29DA6FC5A2D05BF73376F108A0D1B0F7EB8D47D3AF09580004A47DAF84F291074534890E39A6282E5A4834FAA7
	sleep 2
	freechains --host=localhost:8333 peer localhost:8332 send '#sala_de_estudos_1'
	linha=$(sed -n '25p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=A42C9A103A3E0DFD44DF8A83BC745BD69DEB47F69912424650B546D3DFC1C36806855E69A5E1EBB527E7EADEAA6676429317605EA3D7C9F02AF442E5E3298C9B
	sleep 2
	freechains --host=localhost:8334 peer localhost:8332 send '#sala_de_estudos_1'
	linha=$(sed -n '26p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=74BD30AF8EE746886A58FFB8FC410E12928D3B127CE2829527B32E18DEA5D190CC6CD2DFA497766D081B953D5BBB5DE82C45F1534E97E079D98A79CB9429F26D


for n in 2 3 4 5 6


do

        freechains --host=localhost:8331 peer localhost:833$n send '#sala_de_estudos_1'

done

for o in 1 2 3 4 5 6

do
	freechains --host=localhost:833$o chain '#sala_de_estudos_1' consensus
	sleep 1
done
