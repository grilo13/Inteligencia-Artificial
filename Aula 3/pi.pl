%Descricao do problema:
% PESQUISA A*

%estado_inicial(Estado)
%estado_final(Estado)

%representacao dos operadores
%op(Eact,OP,Eseg,Custo)

%representacao dos nos
%no(Estado,no_pai,Operador,Custo,H+C,Profundidade)

pesquisa(Problema,Alg):-
    consult(Problema),
    estado_inicial(S0),
    pesquisa(Alg,[no(S0,[],[],0,1,0)],Solucao),
    escreve_seq_solucao(Solucao).
  
%pesquisa A*
%tem em conta o f de cada nó, que é igual à heuristica + o custo até chegar ao nó prentedido
pesquisa(a,E,S):- pesquisa_a(E,S).

%pesquisa gready ou ansiosa
%tem em conta o f de cada nó, se é igual à heuristica h
pesquisa(g,E,S) :- pesquisa_g(E,S).
  
%pesquisa_a([],_):- !,fail.
%pesquisa A*
  pesquisa_a([no(E,Pai,Op,C,HC,P)|_],no(E,Pai,Op,C,HC,P)):- estado_final(E).
  
  pesquisa_a([E|R],Sol):- expande(E,Lseg), esc(E),
                          insere_ord(Lseg,R,Resto),
                          pesquisa_a(Resto,Sol).

  expande(no(E,Pai,Op,C,HC,P),L):- findall(no(En,
    no(E,Pai,Op,C,HC,P),Opn,Cnn,HCnn,P1),
      (op(E,Opn,En,Cn),P1 is P+1, Cnn is Cn+C, h(En,H), 
        HCnn is Cnn+H), L).

%pesquisa ansiosa ou greedy
% a unica alteração está no expande -> HCnn is H para greedy, e HCnn is Cnn+H para A* (como dizem as formulas dos mesmos)
pesquisa_g([no(E,Pai,Op,C,HC,P)|_],no(E,Pai,Op,C,HC,P)):- estado_final(E).
  
pesquisa_g([E|R],Sol):- expande_g(E,Lseg), esc(E),
                          insere_ord(Lseg,R,[Nmenor|_R1]),
                          pesquisa_g([Nmenor],Sol).

expande_g(no(E,Pai,Op,C,HC,P),L):- findall(no(En,
  no(E,Pai,Op,C,HC,P),Opn,Cnn,HCnn,P1),
    (op(E,Opn,En,Cn),P1 is P+1, Cnn is Cn+C, h(En,H), 
      HCnn is H), L).
  
  
  insere_ord([],L,L).
  insere_ord([A|L],L1,L2):- insereE_ord(A,L1,L3), insere_ord(L,L3,L2).
  
  insereE_ord(A,[],[A]).
  insereE_ord(A,[A1|L],[A,A1|L]):- menor_no(A,A1),!.
  insereE_ord(A,[A1|L], [A1|R]):- insereE_ord(A,L,R).
  
  menor_no(no(_,_,_,_,N,_), no(_,_,_,_,N1,_)):- N < N1.
  
  escreve_seq_solucao(no(E,Pai,Op,Custo,_HC,Prof)):- write(custo(Custo)),nl,
                                            write(profundidade(Prof)),nl,
                                            escreve_seq_accoes(no(E,Pai,Op,_,_,_)).
  
  
  escreve_seq_accoes([]).
  escreve_seq_accoes(no(E,Pai,Op,_,_,_)):- escreve_seq_accoes(Pai),
                                                write(e(Op,E)),nl.
  
  esc(A):- write(A), nl.