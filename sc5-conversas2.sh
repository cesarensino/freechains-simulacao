#!/bin/bash

data=$(date -d "+15 days" +"%Y-%m-%d %H:%M:%S.%3N")
for i in 1 2 3 4 5

do
	freechains-host --port=833$i now '(cat $data)'
done

	freechains --host=localhost:8331 chain '#sala_de_estudos_1' like '2_91F9A0AC95351C3BCD1591FE8CEC07FCF4FC19C50E46CE298C6575EB05071F2F' --sign='FF8B431553239A5DE4617B959E225DBAA60F8D4B76FBBD073B5BC02C38EBEA3193C400CE198E23F11CE2CA67701EDD40EC15BBA7C7297DD475171E6E4214A331'

        linha=$(sed -n '6p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=74BD30AF8EE746886A58FFB8FC410E12928D3B127CE2829527B32E18DEA5D190CC6CD2DFA497766D081B953D5BBB5DE82C45F1534E97E079D98A79CB9429F26D
	sleep 2

	linha=$(sed -n '7p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=79943C36DC70950519A87029E729D715738CFA29DA6FC5A2D05BF73376F108A0D1B0F7EB8D47D3AF09580004A47DAF84F291074534890E39A6282E5A4834FAA7
	sleep 2
	freechains --host=localhost:8333 peer localhost:8332 send '#sala_de_estudos_1'
	linha=$(sed -n '8p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8334 chain '#sala_de_estudos_1' post inline "$linha" --sign=A42C9A103A3E0DFD44DF8A83BC745BD69DEB47F69912424650B546D3DFC1C36806855E69A5E1EBB527E7EADEAA6676429317605EA3D7C9F02AF442E5E3298C9B
	sleep 2
	freechains --host=localhost:8334 peer localhost:8332 send '#sala_de_estudos_1'
	linha=$(sed -n '9p' /tmp/freechains/conversa.txt)
	freechains --host=localhost:8332 chain '#sala_de_estudos_1' post inline "$linha" --sign=74BD30AF8EE746886A58FFB8FC410E12928D3B127CE2829527B32E18DEA5D190CC6CD2DFA497766D081B953D5BBB5DE82C45F1534E97E079D98A79CB9429F26D
	sleep 2
	freechains --host=localhost:8332 peer localhost:8333 send '#sala_de_estudos_1'
        linha=$(sed -n '10p' /tmp/freechains/conversa.txt)
        freechains --host=localhost:8333 chain '#sala_de_estudos_1' post inline "$linha" --sign=79943C36DC70950519A87029E729D715738CFA29DA6FC5A2D05BF73376F108A0D1B0F7EB8D47D3AF09580004A47DAF84F291074534890E39A6282E5A4834FAA7
        freechains --host=localhost:8332 peer localhost:8333 send '#sala_de_estudos_1'

