# freechains-simulacao
Exercício de Conversação nesta aplicação P2P


# Introdução

> Este trabalho é uma atividade acadêmica realizada por este aluno para estudos da plataforma Freechains, que foi desenvolvida pelo Professor Francisco Santana, professor do Departamento de Ciência da Computação da UERJ. A aplicação está no repositório https://github.com/Freechains/README, e pode ser baixada para utilização, bem como materiais de ensino, para serem explorados em seus conceitos e formas de trabalho de maneira plena.

# Problema e Intenção da Aplicação 

  O problema a ser estudado com a simulação foi o de criar uma conversação de modo que o host pioneiro atuasse com menos frequência do que o Host 2, pois este centralizaria as respostas nele, advindas de outros hosts. O pioneiro atuaria de maneira a premiar posts através de seu poder de likes, privilegiando o Host 2, como uma promoção para conseguir apoiar o fluxo de tráfego neste host. Transpassando para o mundo real, basicamente, o pioneiro atua como um professor, o Host 2, atua como um moderador, e os demais hosts aprendizes nesses fluxos;

# Natureza das Mensagens por Autor

  O host 1 é o pioneiro e atua levantando questões, o host 2 é o moderador e atua tirando duvidas e propondo atividades, os demais hosts atuam no fórum de modo a responder as atividades e levantar dúvidas. A exceção é o Host 6 que entra como newbie tardiamente e troll e praticamente não consegue participar dos fluxos;

# Comportamento de Autores com Likes e Dislikes

  No caso de likes e dislikes, o Host 2 participa mais ativamente do fórum, podendo distribuir likes concedidos, o Host 6 pioneiro, tem seu fluxo interrompido por um dislike. O Host 1 premia com likes e os demais hosts, recebem likes como forma de recompensa pela participação ativa;

# Conclusão

  O resultado dessa simulação demonstrou que é possível um usuario criador dos fóruns usar likes e deslikes para incentivar o uso dos espaços, bem como saber que nem toda troca de mensagens indiscriminada pode ser vista como algo positivo, uma vez que a intençao é que um conteúdo seja visto por todos e consentido em sua agregação de conteúdo para o fórum, podendo resultar em reputação posiva ou bloqueios inerentes de atividades aparentemente inócuas porém fora das regras estabelecidas.

# Manual de Utilização dos Scripts

1) Utilizar um ambiente Linux, baixar os arquivos e extrair para a pasta /tmp;
2) Dentro do diretório /tmp/freechains, aplicar o comando chmod +x *.sh no terminal;
3) Para executar a simulação, aplicar ./simul.sh no terminal;
4) Para refazer a simulação ou remover todos os objetos da memória, aplicar ./apaga.sh;

