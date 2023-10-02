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
