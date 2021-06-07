% Varivaveis turistas, dominio jangadas

%10 variaias, cardinal # do dominio = 3, aqui temmos 3^10

%ou

% variaveis jangadas, dominio conjuntos (listas) de turistas

%3 variaveis, #dominio todos os subconjuntos de 10 turistas - 2^10 elementos = 1024

/*
(1,2,3) - 2, 4, 8 ---- 2^n (n numero de bits)

0 1 0
0 0 0
1 0 1

*/

%Grupo 1
% Lista de turistas na margem, lista turista na J1,.... j2,j3)
/*

EXERCICIO 1

estado_inicial(e[t1,t2,t3,t4,t5,t6,t7,t8,t9,t10],[],[],[]).

estado_final(e[],_,_,_).

op(e[T1|R], LJ1, LJ2, LJ3), entra(T1,J1), e(R,[T1|LJ1], LJ2,LJ3),1) :-
    soma_pesos([T1|LJ1],P1), P1 < 140.

op(e[T1|R], LJ1, LJ2, LJ3), entra(T1,j2), e(R,LJ1,[T1|LJ2],LJ3),1) :-
    soma_pesos([T1|LJ2],P1), P1 < 140.

op(e[T1|R], LJ1, LJ2, LJ3), entra(T1,j3), e(R,LJ1,LJ2,[T1|LJ3]),1) :-
    soma_pesos([T1|LJ3],P1), P1 < 140.

soma_pesos([],0).
soma_pesos([T1|R], N) :- soma_pesos(R,M), peso(T1,P1), N is M + P1.

peso(t1,20).
peso(t2,30).
peso(t3,40).
peso(t4,60). ........ etc até ao t10

EXERCICIO 2
10 nivel que chegamos a folha sem turistas para por, logo a profundidade é no nivel 10
A ramificação (numero de filhos do no) média de cada estado é de 2 ou 3, nos expandidos = 3^10, 3^9.....3^1.. = x(como a solucao ta no nivel 10)

Exercicio 3
nos expandidos = 3^10, 3^9.....3^1


EXERCICIO 4
- Heuristica admissivel = heuristica optimista, olha para um estado e preve a distancia que ele se encontra do estado final
- Podia ser dizer quantos turistas ainda estão na marge - porque o estado final tem 0 turistas na margem
- Ver quantas ações faltavam ainda (contar o numero de turistas) - nao e uma boa ou muito boa heuristica

EXERICIIO 5
- Merlhor pesqusia informada
- Greddy não, ia-se perder porque só ia seguir o melhor h, e ia escolher ao calhas e entrar em vários cilcos

- A*- Melhor, porque já tem em conta a distancia anterior e vai corrigindo caminhos que não são bons
*/


%Grupo 2

%Exercicio 1
%seguindo o primeiro exemplo
/*estado_inicial(e(v(t(1),[1,2,3],_), v(t(2),[1,2,3],_)],v(t(3),[1,2,3],_),v(t(4),[1,2,3],_), v(t(5),[1,2,3],_), 
                    v(t(6),[1,2,3],_), v(t(7),[1,2,3],_), v(t(8),[1,2,3],_), v(t(9),[1,2,3],_), v(t(10),[1,2,3],_)], [])).

%Exercicio 2
%sucessir vai a lista de elementos nao instaciados e coloca na lista de instanciados

%sucessor(e([v(N,D,V)|R],E),e(R,[v(N,D,V)|E])):- member(V,D).

%Exercicio 3
% [t1,....t10], [],[],[]
% [t2,....,t10],[t1],[],[]
% [t2,....[t10], [],[t3,[]

% ou

/*
[t1,....t10],
[t2,....t10], t1=j1
[t2,....t10], t1=j2
[t1,....t10], t1=j3

----
[J1,...,J3]
J1=[] J1=[T1]  .....J1 = [t1,....,t10]


%Exercicio 3 - as restricoes do problema

-> Com variaveis turistas
- Colecionar todos os turistas de uma jangada e somar o seu peso se for < 140 tudo ok, senão viola a restrição

- fazer o mesmo para as 3 jangadas

---------------------------------

-> Com variaveis jangadas
- somar o peso dos turistas do valor da jangada
- fazer para as 3 jangadas

- o memso turista nao pode estar em mais do que uma jangada 
- intercepção de J1, J2, J3 tem de ser vazia


%EXERCICIO 4
-> Com variaveis turistas

ve_restricoes(e(Ninst,Inst)) :-
    findall(P, (member(v(N,_,1), peso(N,Kg))),Lj1), soma(Lj1,L1), N1<140,
    findall(P, (member(v(N,_,2), peso(N,Kg))),Lj1), soma(Lj1,L1), N2<140,
    findall(P, (member(v(N,_,3), peso(N,Kg))),Lj1), soma(Lj1,L1), N3<140.

-> Com variaveis jangadas

ve_restricoes(e(Ninst,Inst)) :- member(v(j(1),_,Lt1), Inst),
                                somar_peso(Lt1,N), N<140


% EXERCICIO 5
- Com variavel turista, a profundidade é a 10
- Com variavel jangadas, a profundidade é a 3  (a profundidade da solucao é o numero de variaveis, pois no ultimo nivel instancio a ultima variavel)


% Exercicio 6
- Forwarch cheking - quando instancio uma variavel (turista para jangada 1 por exemplo, e cortamos a jangada do dominio, o que não faz sentido neste problema)

- COm variaveis turistas    
- Não podemso cortar logo a jangada apenas com 1 turista, então só podemos cortar quando já estiverem os 140 de peso na jangada

- Então o forwarc checking não era uma boa opcção para este problema

- COm variaveis jangadas
- Faz sentido sim, porque se tirarmos os cliertnes da jangada 1 do dominio, é mais facil de escolher para as outros os turistas restantes
- faz sentido instanciar as variaves com forward checking


*/