%estado

%para corer
%[pni] e meter pesquisa(jarros,largura)
%para mudar o que queremos em cada jarro meter estado_final((5,1)) quando queremos 5 no primeiro e 1 no segundos

%Complexidade espacial - capacidade de nós que podem haver em memória

%(Conteudo_de_c1,Conteudo_de_c2,Conteudo_de_saco)

%estado final
estado_inicial((0,0)).

%estado final
estado_final((0,1)).


capacidade(c1,3).
capacidade(c2,2).

%Predicado operador de transição de estados
%Primeiro argumento é um estado (A,B)
%Segundo argumento e(c1), significa enche jarro c1, e vai para o estado to terceiro argumento (A1,B)
%Capacidade (c1,A1), e A \= A1, quer dizer que se altera o estado, server para garantir que há mudança de estado
%op(Estado_act,operador,Estado_seg,Custo)
op((A,B),e(c1),(A1,B),1):- capacidade(c1,A1), A \= A1.
op((A,B),e(c2),(A,B1),1):- capacidade(c2,B1),B\=B1.
op((A,B),d(c1),(0,B),1):- A\= 0.   %despejar c1, se tiver água lá dentro
op((A,B),d(c2),(A,0),1):- B\=0.    %despejar c2, se tiver água lá dentro (1 litro)
op((A,B),d(c1,c2),(A2,B3),1):- capacidade(c2,B1), B2 is A+B,    %despejar c1 e c2, vai para A(A2,B3), B1 capacidade maxima de c2
                              min(B3,B1,B2), A3 is B2 - B3,     %b3 tem que ser o falar minimo entre b1 e b2, A3 é o que fica no outro jarro
                              max(A2,A3,0), A\=A2,B\=B3.        %max entre A2 e A3, sendo que A3 pode ser menor que 0, e ver se existe mudança de estado, só funciona se se alteraren os dois
op((B,A),d(c2,c1),(B3,A2),1):- capacidade(c1,B1), B2 is A+B, 
                              min(B3,B1,B2), A3 is B2 - B3,
                              max(A2,A3,0), A\=A2,B\=B3.

max(A,A,B):- A>B,!.
max(A,_,A).

min(A,A,B):- A<B,!.
min(A,_,A).