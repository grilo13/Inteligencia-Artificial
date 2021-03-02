homem('Afonso Henriques','rei de Portugal',1109).
homem('Henrique de Borgonha','conde de Portugal',1069).

homem('Sancho I','rei de Portugal',1154).
homem('Fernando II','rei de Leão',1137).
homem('Afonso IX', 'rei de Leão e Castela', 1171).
homem('Afonso II', 'rei de Portugal',1185).

homem('Sancho II', 'rei de Portugal',1207).
homem('Afonso III', 'rei de Portugal',1210).


mulher('Teresa de Castela', 'condessa de Portugal', 1080).
mulher('Mafalda', 'condessa de Saboia', 1125).
mulher('Urraca', 'infanta de Portugal',1151).
mulher('Dulce de Barcelona','infanta de Aragão',1160).
mulher('Berengária', 'infanta de Portugal',1194).
mulher('Urraca C','infanta de Castela',1186).


filho('Afonso Henriques','Henrique de Borgonha').
filho('Afonso Henriques','Teresa de Castela').
filho('Urraca','Afonso Henriques').
filho('Sancho I','Afonso Henriques').
filho('Urraca','Mafalda').
filho('Sancho I','Mafalda').
filho('Afonso IX','Urraca').
filho('Afonso IX','Fernando II').
filho('Afonso II','Sancho I').
filho('Afonso II','Dulce de Barcelona').
filho('Berengária','Sancho I').
filho('Berengária','Dulce de Barcelona').
filho('Sancho II','Afonso II').
filho('Afonso III','Afonso II').
filho('Sancho II','Urraca C').
filho('Afonso III','Urraca C').

% 1) Predicado irmão
irmao(Nome1,Nome2) :-
    filho(Nome1,X),
    filho(Nome2,X),
    Nome1 \= Nome2.

% Outro predicado irmão que não contém irmãos repetidos
irmao1(Nome1,Nome2) :-
    findall(A:B, irmao(A,B),L), sort(L,L1), member(Nome1:Nome2,L1).

% 2) Predicado primo direito
primo_direito(Nome1,Nome2) :-
    filho(Nome1, X),
    filho(Nome2,Y),
    X \= Y,
    irmao(X,Y).

% 3) Predicado que mostra uma lista com todos os irmãos de Nome1
% setof eliminita os repetidos 
% instanciar primeiro como pessoa para sabermos sempre o valor
irmaos(Nome1,L) :- pessoa(Nome1),setof(Z, irmao(Nome1,Z),L).

%irmaos(Nome1,L) :- pessoa(Nome1),findall(Z, irmao(Nome1,Z),L).

pessoa(X) :- homem(X,_,_).
pessoa(X) :- mulher(X,_,_).

% 4) Predicado primo
primo(X, Y):- primo_direito(X, Y).

primo(X,Y) :- filho(X,P), filho(Y,Q), primo(P,Q).

primo(X,Y) :- filho(X,P), primo(P,Y).

% 5) Predicado esposa
esposa(X, Y):- mulher(X,_,_), homem(Y,_,_),filho(L,X),filho(L,Y).

% 6) Predicado descende
% recebo uma lista 
% pessoa garante que X é sempre uma pessoa, encontrando os filhos dessa mesma pessoa
descendentes1(X,L):- descendentes([X],L).

descendentes([],[]).
descendentes([X|S],R):- pessoa(X), findall(A,filho(A,X),Fs),
descendentes(Fs,Rs), append(Fs,Rs,R1),
descendentes(S,Ss), append(R1,Ss,R). 