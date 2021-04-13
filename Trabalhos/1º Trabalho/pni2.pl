%consult(pi), pesquisa(cavalo,a)
%Descricao do problema:
:- dynamic(fechado/1).
:- dynamic(maxNL/1).
:- dynamic(nos/1).

maxNL(0).
nos(0).

inc:- retract(nos(N)), N1 is N+1, asserta(nos(N1)).

actmax(N):- maxNL(N1), N1 >= N,!.
actmax(N):- retract(maxNL(_N1)), asserta(maxNL(N)).
 

%estado_inicial(Estado)
%estado_final(Estado)

%representacao dos operadores
%op(Eact,OP,Eseg,Custo)

%representacao dos nos
%no(Estado,no_pai,Operador,Custo,H+C,Profundidade)

pesquisa(Problema,Alg):-
  consult(Problema),
  estado_inicial(S0),
  %pesquisa(Alg,[no(S0,[],[],0,1,0)],Solucao),
  pesquisa(Alg,[no(S0,[],[],0,0)],Solucao),
  escreve_seq_solucao(Solucao),
  retract(nos(Ns)),retract(maxNL(NL)),
  asserta(nos(0)),asserta(maxNL(0)),
  write(nos(visitados(Ns),lista(NL))),
  retractall(fechado(_)).


pesquisa(a,E,S):- pesquisa_a(E,S).
  
pesquisa(g,E,S):- pesquisa_g(E,S).

pesquisa(profundidade,E,S):- pesquisa_profundidade(E,S).

pesquisa(largura,Ln,Sol):- pesquisa_largura(Ln,Sol).

pesquisa(it,Ln,Sol):- pesquisa_it(Ln,Sol,1).

pesquisa_it(Ln,Sol,P):- retractall(fechado(E)), pesquisa_pLim(Ln,Sol,P).
pesquisa_it(Ln,Sol,P):- P1 is P+1, pesquisa_it(Ln,Sol,P1).

%Pesquisa profundidade
pesquisa_profundidade([no(E, Pai, Op, C, P)|_], no(E, Pai, Op, C, P)):-
  estado_final(E), inc.

pesquisa_profundidade([E|R], Sol):- inc ,asserta(fechado(E)),
  expandep(E, Lseg), 
  esc(E),
  insere_inicio(Lseg, R, Resto),
  length(Resto,N),actmax(N),
  pesquisa_profundidade(Resto, Sol).

pesquisa_largura([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P)):- 
  estado_final(E), inc.

pesquisa_largura([E|R],Sol):- inc ,asserta(fechado(E)),expandep(E,Lseg),
  esc(E),
  insere_fim(Lseg,R,Resto),
  length(Resto,N),actmax(N),
  pesquisa_largura(Resto,Sol).

expandep(no(E,Pai,Op,C,P),L):- findall(no(En,no(E,Pai,Op,C,P),Opn,Cnn,P1),
                                      (op(E,Opn,En,Cn),
                                      \+ fechado(no(En,_,_,_,_)),
                                      P1 is P+1, Cnn is Cn+C),
                                      L).

%Pesquis Iterativa
pesquisa_pLim([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P),_):- 
  estado_final(E), inc.

pesquisa_pLim([E|R],Sol,Pl):- inc ,asserta(fechado(E)),
    expandePl(E, Lseg,Pl), 
    esc(E),
    insere_inicio(Lseg, R, Resto),
    length(Resto,N),actmax(N),
    pesquisa_pLim(Resto, Sol,Pl).

expandePl(no(E,Pai,Op,C,P),[],Pl):- Pl =< P, ! .
expandePl(no(E,Pai,Op,C,P),L,_):- findall(no(En,no(E,Pai,Op,C,P),Opn,Cnn,P1),
                                      (op(E,Opn,En,Cn),
                                      \+ fechado(no(En,_,_,_,_)),
                                      P1 is P+1, Cnn is Cn+C),
                                      L).

insere_inicio([], L, L).
insere_inicio(L, [], L).
insere_inicio(R, T, L):-append(R,T,L).

%pesquisa_a([],_):- !,fail.
pesquisa_a([no(E,Pai,Op,C,HC,P)|_],no(E,Pai,Op,C,HC,P)):- estado_final(E),inc.

pesquisa_a([E|R],Sol):- inc, asserta(fechado(E)), expande(E,Lseg), esc(E),
  insere_ord(Lseg,R,Resto),
  length(Resto,N), actmax(N),
  pesquisa_a(Resto,Sol).
                              

%pesquisa_g([],_):- !,fail.
pesquisa_g([no(E,Pai,Op,C,HC,P)|_],no(E,Pai,Op,C,HC,P)):- estado_final(E).

pesquisa_g([E|R],Sol):- inc,  asserta(fechado(E)),  expande_g(E,Lseg), %esc(E),
  insere_ord(Lseg,R,Resto), length(Resto,N), actmax(N),
  pesquisa_g(Resto,Sol).

expande(no(E,Pai,Op,C,HC,P),L):- findall(no(En,no(E,Pai,Op,C,HC,P),Opn,Cnn,HCnn,P1),
	(op(E,Opn,En,Cn), \+ fechado(no(En,_,_,_,_,_)),
	P1 is P+1, Cnn is Cn+C, h(En,H), HCnn is Cnn+H), L).

expande_g(no(E,Pai,Op,C,HC,P),L):- findall(no(En,no(E,Pai,Op,C,HC,P),Opn,Cnn,H,P1),
	(op(E,Opn,En,Cn),
  \+ fechado(no(En,_,_,_,_,_)),
	P1 is P+1, Cnn is Cn+C, h(En,H)), L).

insere_ord([],L,L).
insere_ord([A|L],L1,L2):- insereE_ord(A,L1,L3), insere_ord(L,L3,L2).

insereE_ord(A,[],[A]).
insereE_ord(A,[A1|L],[A,A1|L]):- menor_no(A,A1),!.
insereE_ord(A,[A1|L], [A1|R]):- insereE_ord(A,L,R).

menor_no(no(_,_,_,_,N,_), no(_,_,_,_,N1,_)):- N < N1.

insere_fim([],L,L).
insere_fim(L,[],L).
insere_fim(R,[A|S],[A|L]):- insere_fim(R,S,L).

%Funções para escrever
%EScreve seq_solução e seq_ações retiradas dos exercicios das aulas práticas
/*escreve_seq_solucao(no(E,Pai,Op,Custo,_HC,Prof)):- 
  write(custo(Custo)),nl,
  write(profundidade(Prof)),nl,
  escreve_seq_accoes(no(E,Pai,Op,_,_,_)).*/

escreve_seq_solucao(no(E,Pai,Op,Custo,Prof)):- 
  write(custo(Custo)),nl,
  write(profundidade(Prof)),nl,
  escreve_seq_accoes(no(E,Pai,Op,_,_)).

/*escreve_seq_accoes([]).
escreve_seq_accoes(no(E,Pai,Op,_,_,_)):- 
  escreve_seq_accoes(Pai),
  write(e(Op,E)),nl.*/

escreve_seq_accoes([]).
escreve_seq_accoes(no(E,Pai,Op,_,_)):- 
  escreve_seq_accoes(Pai),
  write(e(Op,E)),nl.

esc(A):- write(A), nl.
