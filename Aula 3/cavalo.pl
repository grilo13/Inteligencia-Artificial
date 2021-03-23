estado_inicial((1,1)).
estado_final((7,7)).

lim(X,Y) :- X>=1, 8=<X , Y=<8, Y>=1.

%op((X,Y),(1,2),(X1,Y1),1) :- X1 is X+1, Y1 is Y+2, lim(X1,Y1).
%op((X,Y),(-1,2),(X1,Y1),1) :- X1 is X-1, Y1 is Y+2, lim(X1,Y1).

%op((X,Y),(-1,2),(X1,Y1),1) :- X1 is X-1, Y1 is Y+2, lim(X1,Y1).


op((X,Y),(N,M),(X1,Y1),1) :- member(N,[1,-1]),
            member(M,[2,-2]),
            X1 is X+N, Y1 is Y+M, lim(X1,Y1).

op((X,Y),(N,M),(X1,Y1),1) :- member(M,[1,-1]),
            member(N,[2,-2]),
            X1 is X+N, Y1 is Y+M, lim(X1,Y1).

%h((X,Y),Val) :- estado_final((Xf,Yf)), Vi is Xf-X, Vj is Yf-Y, mod(Vj,Yf,Y), Val is (Vi+Vj) div 3.
h((X,Y),Val) :- estado_final((Xf,Yf)), mod(Vi,Xf,X), mod(Vj,Yf,Y), Val is (Vi+Vj) / 3.

mod(Vj,X,Y) :- X<Y, Vj is Y-X.
mod(Vj,X,Y) :- Vj is X-Y.