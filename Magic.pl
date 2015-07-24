%/Predicate to calculate list length/%
longueur([],0):-!.
longueur([T|Q],N):-longueur(Q,M), N is M+1.

%/Predicate to concatenate a list to another in a new list/%
concat([],L,L):-!.
concat([T|Q],L,[T|R]):-concat(Q,L,R).

%/Predicate to determine whether an element is part of a list/%
element([X|_],X).
element([_|Q],X):-element(Q,X).

%/Predicate calculate the sum of numbers contained in the list/%
somme([],0):-!.
somme([T|Q],S):-somme(Q,S1), S is T + S1.

%/Predicate returning square dimension (defined as an alias of longueur)/%
dimension(Ca,N):-longueur(Ca,N).

%/Predicate which returns the position of an element in a list/%
element_n(1,[X|_],X):-!.
element_n(N,[_|Q],X):- M is N-1, element_n(M,Q,X).

%/Predicate returning the N-th column of a square, if N is lower or equal to square dimension/%
colonne_n(_,[],[]):-!.
colonne_n(N,[T|Q],[X|R]):-element_n(N,T,X),colonne_n(N,Q,R).

%/Predicate returning all columns of a square/%
colonnes(N,Ca,[]):-dimension(Ca,Dim),N>Dim,!.
colonnes(I,Ca,[CI|R]):-colonne_n(I,Ca,CI),J is I+1,colonnes(J,Ca,R).
colonnes(Ca,C):-colonnes(1,Ca,C).

%/Predicate returning the diagonal from top left to bottom right of a square/%
diagonale1(_,[],[]):-!.
diagonale1(I,[T|Q],[D|F]):-element_n(I,T,D), J is I+1,diagonale1(J,Q,F).
diagonale1(Ca,D1):-diagonale1(1,Ca,D1).

%/Predicate returning the diagonal from bottom left to top right of a square/%
diagonale2(_,[],[]):-!.
diagonale2(J,[T|Q],[D|F]):-element_n(J,T,D),I is J-1,diagonale2(I,Q,F).
diagonale2(Ca,D2):-dimension(Ca,Dim),diagonale2(Dim,Ca,D2).

%/Predicate assigning to C, D1 and D2 respectively all columns, the first diagonal and the second digonal of a square/%
composantes(Ca,[Ca|[C,D1,D2]]):-colonnes(Ca,C),diagonale1(Ca,D1),diagonale2(Ca,D2).

%/Predicate determining whether the sum of each component is the same/%
meme_somme([],S):-!.
meme_somme([T|Q],S):- T\=[D|F],somme([T|Q],ST),ST=S,!.
meme_somme([T|Q],S):- meme_somme(T,S),meme_somme(Q,S).

%/Main predicate/%
magique(Ca):-composantes(Ca,[[DT|FT]|Q]),somme(DT,S),meme_somme(FT,S),meme_somme(Q,S).

%/Call example returning true:/%
%/magique([[8,3,4],[1,5,9],[6,7,2]])./%