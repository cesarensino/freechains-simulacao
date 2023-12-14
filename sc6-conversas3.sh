#!/bin/bash


data=$(date -d "+30 days" +"%Y-%m-%d %H:%M:%S.%3N")
for i in 1 2 3 4 5

do
	freechains-host --port=833$i now '(cat $data)'

done

freechains --host=localhost:8331 chain '#sala_de_estudos_1' like '2_E84EC7F10B128FE73DEB60B77FB55147444ECECA9C1A8C41A645D517510ED164' --sign='FF8B431553239A5DE4617B959E225DBAA60F8D4B76FBBD073B5BC02C38EBEA3193C400CE198E23F11CE2CA67701EDD40EC15BBA7C7297DD475171E6E4214A331'

for j in 2 3 4 5


do

	freechains --host=localhost:8331 peer localhost:833$j recv '#sala_de_estudos_1'

done

        linha=$(sed -n '11p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=74BD30AF8EE746886A58FFB8FC410E12928D3B127CE2829527B32E18DEA5D190CC6CD2DFA497766D081B953D5BBB5DE82C45F1534E97E079D98A79CB9429F26D
        sleep 2
        linha=$(sed -n '12p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=79943C36DC70950519A87029E729D715738CFA29DA6FC5A2D05BF73376F108A0D1B0F7EB8D47D3AF09580004A47DAF84F291074534890E39A6282E5A4834FAA7

	sleep 2
        linha=$(sed -n '13p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8331 chain '#sala_de_estudos_1' post inline "$linha" --sign=FF8B431553239A5DE4617B959E225DBAA60F8D4B76FBBD073B5BC02C38EBEA3193C400CE198E23F11CE2CA67701EDD40EC15BBA7C7297DD475171E6E4214A331

        linha=$(sed -n '14p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8335 chain '#sala_de_estudos_1' post inline "$linha" --sign=93EBE5493F9C8D5141C6D32D04015921BBD00A44127C1694A8733D05BAE201DBE4A9DD5C519E128F9039A1CD5C8E0C96C8F6D8DD1FF005DC56B339E2DD7C5F61
        
	sleep 2
	linha=$(sed -n '15p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=74BD30AF8EE746886A58FFB8FC410E12928D3B127CE2829527B32E18DEA5D190CC6CD2DFA497766D081B953D5BBB5DE82C45F1534E97E079D98A79CB9429F26D


	sleep 2
	linha=$(sed -n '16p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=A42C9A103A3E0DFD44DF8A83BC745BD69DEB47F69912424650B546D3DFC1C36806855E69A5E1EBB527E7EADEAA6676429317605EA3D7C9F02AF442E5E3298C9B
	sleep 2
        linha=$(sed -n '16p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=A42C9A103A3E0DFD44DF8A83BC745BD69DEB47F69912424650B546D3DFC1C36806855E69A5E1EBB527E7EADEAA6676429317605EA3D7C9F02AF442E5E3298C9B


for m in 3 4 5


do

        freechains --host=localhost:8332 peer localhost:833$m recv '#sala_de_estudos_1'

done

freechains --host=localhost:8331 peer localhost:8332 recv '#sala_de_estudos_1'
for n in 2 3 4 5


do

        freechains --host=localhost:8331 peer localhost:833$n send '#sala_de_estudos_1'

done

for o in 1 2 3 4 5

do
	freechains --host=localhost:833$o chain '#sala_de_estudos_1' consensus
	sleep 1
done


