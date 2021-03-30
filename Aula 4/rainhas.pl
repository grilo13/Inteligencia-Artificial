%Testes no terminal
%?- estado_inicial(A).
%A = e([v(c(1),[1,2,3,4,5,6,7,8],_),v(c(2),[1,2,3,4,5,6,7,8],_),v(c(3),[1,2,3,4,5,6,7,8],_),v(c(4),[1,2,3,4,5,6,7,8],_),v(c(5),[1,2,3,4,5,6,7,8],_),v(c(6),[1,2,3,4,5,6,7,8],_),v(c(7),[1,2,3,4,5,6,7,8],_),v(c(8),[1,2,3,4,5,6,7,8],_)],[])

%| ?- estado_inicial(A), op(A,_,B,C).

%A = e([v(c(1),[1,2,3,4,5,6,7,8],1),v(c(2),[1,2,3,4,5,6,7,8],_),v(c(3),[1,2,3,4,5,6,7,8],_),v(c(4),[1,2,3,4,5,6,7,8],_),v(c(5),[1,2,3,4,5,6,7,8],_),v(c(6),[1,2,3,4,5,6,7,8],_),v(c(7),[1,2,3,4,5,6,7,8],_),v(c(8),[1,2,3,4,5,6,7,8],_)],[])
%C = 1 ? 

estado_inicial(e([
    v(c(1),[1,2,3,4,5,6,7,8],_),
v(c(2),[1,2,3,4,5,6,7,8],_),
    v(c(3),[1,2,3,4,5,6,7,8],_),
v(c(4),[1,2,3,4,5,6,7,8],_),
v(c(5),[1,2,3,4,5,6,7,8],_),
    v(c(6),[1,2,3,4,5,6,7,8],_),
v(c(7),[1,2,3,4,5,6,7,8],_),
v(c(8),[1,2,3,4,5,6,7,8],_)], [])).

/* Problema gera
%gera o dominio
estado_inicial(e(L,[])):- gera(25,L).


gera(N,L):- geraD(N,D), geraVars(N,D,L).

geraD(0,[]).
geraD(N,[N|R]):- N>0, M is N-1, geraD(M,R).

geraVars(0,_D,[]).
geraVars(N,D,[v(c(N),D,_)|R]):- N>0, M is N-1, geraVars(M,D,R). 

*/

%Restricoes 
%c(i) <> c(j) e |i-j| <> |c(i)-c(j)|

estado_final(e([],LE)) :- ve_restricoes(e([],LE)). %estado final se ve restricoes suceder /obriga a ver se ainda temos instâncias por ver

%operação a se fazer
op(Ec,_,Es,1) :- sucessor(Ec,Es).


sucessor(e([v(N,D,V)| R],E), e(R,[v(N,D,V)| E])) :- member(V,D). %gera em backtraking todos os valores do dominio

ve_restricoes(e(Nafec,Afect)):- \+ (member(v(c(I),Di,Vi), Afect),   %a negação vai ver quando alguma dessas sucede
                                    member(v(c(J),Dj,Vj),Afect),  
                                    I \=J,  %vai ver todos os elementos e C(j), c(i), se algum tem v(i) = v(j), uma restrição falhada, se não continua a ver para todos
                                    (Vi=Vj; modDif(I,J,D1), %vai falhar se tiver a rainha numa linha ou na mesma diagonal
                                    modDif(Vi,Vj,D2), D1=D2)).
%ve_restricoes(e(Nafect,[A])).

modDif(I,J,D):- I>J, D is I-J.
modDif(I,J,D):- I =< J, D is J-I.

%% escreve

esc(L):- sort(L,L1), write(L1), nl, esc1(L1).
esc1([]).
esc1([v(_,_,V)|R]):- esc(8,V,1),  esc1(R).
esc(V,V,V):- !,write(r),nl.
esc(V,N,V):- !,write('_'),nl.
esc(V,N,N):-!,write(r), M is N+1, esc(V,N,M).
esc(V,N1,N):-write('_'), M is N+1, esc(V,N1,M).