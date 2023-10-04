% Punto 1
% Definir el predicado elimina(X, Ys, Zs). Donde X es un elemento, Ys es una lista y Zs es
% la lista obtenida como resultado de la eliminaci?n de X de Ys
elimina(_, [], []).
elimina(X, [X|RES], RES).
elimina(X, [CABEZA | COLA], [CABEZA|RES]) :- X =\= CABEZA, elimina(X, COLA, RES).

% Punto 2
% Definir el predicado eliminar todos eliminaTodos(X, Ys, Zs). Donde X es un
% elemento, Ys es una lista y Zs es la lista obtenida como resultado de la eliminaci?n de todos
% los elementos X de Ys.
eliminaTodos(_, [], []).
eliminaTodos(X, [X|Ys], Zs) :- eliminaTodos(X, Ys, Zs), !.
eliminaTodos(X, [Y|Ys], [Y | Zs]) :- eliminaTodos(X, Ys, Zs).

% Punto 3
% Define la relaci?n longitud(Ls, X) de forma que X sea la cantidad de elementos de la lista
% Ls.
longitud([], 0).
longitud([_| COLA], RES) :- longitud(COLA, P), RES is 1 + P.

% Punto 4
% Utilizar un predicado concatenar(Xs, Ys, Zs). Donde Xs y Ys son las listas a concatenar
% y Zs es la lista obtenida como resultado de la concatenaci?n.
concatenar([],Ys,Ys).
concatenar([X|Xs],Ys,[X|Zs]):- concatenar(Xs, Ys, Zs).

% Punto 5
% Utilizando el predicado concatenar/3, definir las siguientes reglas:

% a) prefijo(Xs, Ys): indica si los elementos de Xs est?n al principio de Ys.
prefijo(Xs, Ys) :- concatenar(Xs, _, Ys).

% b) sufijo(Xs, Ys): indica si los elementos de Xs est?n al final de Ys
sufijo(Xs, Ys) :- concatenar(_, Xs, Ys).

% c) sublista(Xs, Ys): indica si Xs es una sublista de Ys.
sublista(Xs, Ys) :- concatenar(_, SUBSTRING, Ys), concatenar(Xs, _, SUBSTRING).

% d) pertenece(X, Xs): si X es un elemento de Xs.
pertenece(X, Xs) :- sublista([X], Xs).

% e) invertirL (Xs, Ys): Ys es Xs con los elementos en orden inverso.
invertirL([], []).
invertirL([Xs|COLA], XsInvertida):- invertirL(COLA, R), concatenar(R, [Xs], XsInvertida).


%6. Define la relación menordelalista(Ls, X) de forma que X sea el menor elemento de la
%lista Ls numérica.

menordelalista([Ls], Ls) :- !.
menordelalista([Ls|LC], Ls):- menordelalista(LC, R), Ls =< R, !.
menordelalista([_|LC], R):- menordelalista(LC, R).

%7. Definir la relación elementos_pares(L1s, L2s) de forma que si L1s es una lista de
%números, entonces L2s es la lista de los elementos pares de L1s.



%8. Generar una lista de hombres filtrando elementos de una lista de personas (que pueden ser
%varones o mujeres: filtraHombres(Xs, Ys). donde Xs es la lista de personas y, Ys es la
%lista de hombres en Xs.

