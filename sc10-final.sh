#!/bin/bash

data=$(date -d "+95 days" +"%Y-%m-%d %H:%M:%S.%3N")
for i in 1 2 3 4 5 6

do
	freechains-host --port=833$i now '(cat $data)'

done

freechains --host=localhost:8331 chain '#sala_de_estudos_1' dislike '7_50FFDC435975F4D66B9327115F9E79929ABB886CCCD2A13ECDA55FC6E504B2FE' --sign='FF8B431553239A5DE4617B959E225DBAA60F8D4B76FBBD073B5BC02C38EBEA3193C400CE198E23F11CE2CA67701EDD40EC15BBA7C7297DD475171E6E4214A331'

freechains --host=localhost:8331 chain '#sala_de_estudos_1' heads
freechains --host=localhost:8331 chain '#sala_de_estudos_1' heads blocked


