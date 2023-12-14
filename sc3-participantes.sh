#!/bin/bash

echo -e "\033[0;31mInclusão de outros participantes e repasse da primeira mensagem\033[0m"

i=1
cpio=$(sed -n '1p' /tmp/freechains/user1/cpub1.txt)


for j in 2 3 4 5

do
	freechains --host=localhost:833$j chains join '#sala_de_estudos_1' $cpio 
	sleep 3
	freechains --host=localhost:833$i peer localhost:833$j send '#sala_de_estudos_1'
	
done 
