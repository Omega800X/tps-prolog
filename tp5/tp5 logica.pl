% Punto 1
% Definir el predicado elimina(X, Ys, Zs). Donde X es un elemento, Ys es una lista y Zs es
% la lista obtenida como resultado de la eliminación de X de Ys
elimina(_, [], []).
elimina(X, [X|RES], RES).
elimina(X, [CABEZA | COLA], [CABEZA|RES]) :- X =\= CABEZA, elimina(X, COLA, RES).

% Punto 2
% Definir el predicado eliminar todos eliminaTodos(X, Ys, Zs). Donde X es un
% elemento, Ys es una lista y Zs es la lista obtenida como resultado de la eliminación de todos
% los elementos X de Ys.
eliminaTodos(_, [], []).
eliminaTodos(X, [X|Ys], Zs) :- eliminaTodos(X, Ys, Zs), !.
eliminaTodos(X, [Y|Ys], [Y | Zs]) :- eliminaTodos(X, Ys, Zs).

% Punto 3
% Define la relación longitud(Ls, X) de forma que X sea la cantidad de elementos de la lista
% Ls.
longitud([], 0).
longitud([_| COLA], RES) :- longitud(COLA, P), RES is 1 + P.

% Punto 4
% Utilizar un predicado concatenar(Xs, Ys, Zs). Donde Xs y Ys son las listas a concatenar
% y Zs es la lista obtenida como resultado de la concatenación.
concatenar([],Ys,Ys).
concatenar([X|Xs],Ys,[X|Zs]):- concatenar(Xs, Ys, Zs).

% Punto 5
% Utilizando el predicado concatenar/3, definir las siguientes reglas:

% a) prefijo(Xs, Ys): indica si los elementos de Xs están al principio de Ys.
prefijo(Xs, Ys) :- concatenar(Xs, _, Ys).

% b) sufijo(Xs, Ys): indica si los elementos de Xs están al final de Ys
sufijo(Xs, Ys) :- concatenar(_, Xs, Ys).

% c) sublista(Xs, Ys): indica si Xs es una sublista de Ys.
sublista(Xs, Ys) :- concatenar(_, SUBSTRING, Ys), concatenar(Xs, _, SUBSTRING).

% d) pertenece(X, Xs): si X es un elemento de Xs.
pertenece(X, Xs) :- sublista([X], Xs).

% e) invertirL (Xs, Ys): Ys es Xs con los elementos en orden inverso.


