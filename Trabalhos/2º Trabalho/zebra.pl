% Problema da zebra
size(8).

estado_inicial(e([
    v(c(1),D,_),                      %cadeira 1....      
              v(c(2),D,_),            %cadeira 2....
                              v(c(3),D,_),
              v(c(4),D,_),
              v(c(5),D,_),
                              v(c(6),D,_),
              v(c(7),D,_),
              v(c(8),D,_)],[])) :- D = ['Maria', 'Manuel', 'Madalena', 'Joaquim', 'Ana', 'Julio','Matilde', 'Gabriel'].


ve_restricoes(e(_Nafec,Afect)):- \+ (member(v(c(I),_Di,Vi), Afect), 
                                    member(v(c(J),_Dj,Vj),Afect),  
                                    I \=J,  %sucede se violar a restrição
                                    restric(I,Vi,J,Vj)).   %VI = VJ vê se há rainhas na mesma casa

%restrict sucede se alguma restrição falha
restric(I,X,J,Y) :- restricoes(L), member(esq(X,Y),L), \+ (I is J+1; (I=1, J=8)).   %restrições(L) é a lista com as restrições

restric(I,X,J,Y) :- restricoes(L), member(dir(X,Y),L), \+ (I is J-1; (I=8, J=1)).

restric(I,X,J,Y) :- restricoes(L), member(lado(X,Y),L), \+ ((I is J-1; (I=1, J=8)); (I is J+1; (I=1,J=8))).

restric(I,X,_,_) :- restricoes(L), member(cabeceira(X),L), \+ (I=5, I=1).

restricoes([esq('Manuel','Maria'), frente('Joaquim','Maria'),lado('Joaquim','Matilde'),cabeceira('Gabriel')]).

modDif(I,J,D):- I>J, D is I-J.
modDif(I,J,D):- I =< J, D is J-I. 

%esc(_).
esc(L):-sort(L, L1), esc_a(L1),nl.

esc_a(L):- size(S), esc_l(L, 1, S).

esc_l([H], S, S):- H = v(_,_,X), write(X),nl.

esc_l([H|T], S, S):- H = v(_,_,X), write(X), nl,esc_l(T, 1, S).

esc_l([H|T], I, S):- I<S, I2 is I+1,
                    H = v(_,_,X), write(X),write(' . '),
                     esc_l(T, I2, S).
