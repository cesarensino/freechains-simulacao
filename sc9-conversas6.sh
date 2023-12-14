#!/bin/bash


data=$(date -d "+90 days" +"%Y-%m-%d %H:%M:%S.%3N")
for i in 1 2 3 4 5 6

do
	freechains-host --port=833$i now '(cat $data)'

done

        
        freechains --host=localhost:8336 chain '#sala_de_estudos_1' post inline "não gosto de matemática" --sign=898CA81F9CDC1256336360747C9D2BBE411B304F84FF57D58FE55556525F451FD043D4275F9D61004AEF8C53F0E8A0048F5E644C632CF5CD48511A859BA2B054
	freechains --host=localhost:8336 peer localhost:8331 send '#sala_de_estudos_1'

	freechains --host=localhost:8331 chain '#sala_de_estudos_1' like '6_CF3B9F932ADBCD7B7D974A22D570F129550C91C3E9E4408269D0C0A3ED3DBBDC' --sign='FF8B431553239A5DE4617B959E225DBAA60F8D4B76FBBD073B5BC02C38EBEA3193C400CE198E23F11CE2CA67701EDD40EC15BBA7C7297DD475171E6E4214A331'


	for n in 2 3 4 5 6
do

        freechains --host=localhost:8331 peer localhost:833$n recv '#sala_de_estudos_1'

done

for m in 2 3 4 5 6


do

        freechains --host=localhost:8331 peer localhost:833$m send '#sala_de_estudos_1'

done

for o in 1 2 3 4 5 6

do
	freechains --host=localhost:833$o chain '#sala_de_estudos_1' consensus
	sleep 1
done
