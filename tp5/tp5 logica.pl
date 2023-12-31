% Punto 1
% Definir el predicado elimina(X, Ys, Zs). Donde X es un elemento, Ys es una lista y Zs es
% la lista obtenida como resultado de la eliminaci?n de X de Ys
elimina(X, [X|RES], RES).
elimina(X, [CABEZA | COLA], [CABEZA|RES]) :- elimina(X, COLA, RES).

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

% f) adyacentes(X, Y, Xs) : si X e Y est�n en posiciones consecutivas en Xs
 adyacentes(X, Y, Xs) :- sublista([X,Y], Xs); sublista([Y,X], Xs).
 
% g) ultimo(Xs, X) : si X es el �ltimo elemento de Xs.
ultimo(Xs, X) :- concatenar(_, [X], Xs).

% h) primeros(Xs, Ys) : si Ys es el resultado de eliminar el �ltimo elemento de Xs.
primeros(Xs, Ys) :- longitud(Xs, A), longitud(Ys, B), A - 1 =:= B, prefijo(Ys, Xs).

%6. Define la relaci�n menordelalista(Ls, X) de forma que X sea el menor elemento de la
%lista Ls num�rica.

menordelalista([Ls], Ls) :- !.
menordelalista([Ls|LC], Ls):- menordelalista(LC, R), Ls =< R, !.
menordelalista([_|LC], R):- menordelalista(LC, R).

%7. Definir la relaci�n elementos_pares(L1s, L2s) de forma que si L1s es una lista de
%n�meros, entonces L2s es la lista de los elementos pares de L1s.

esPar(NUM) :- NUM mod 2 =:= 0.
esImpar(NUM) :- NUM mod 2 =\= 0.
elementos_pares([],[]).
elementos_pares([H|T], [H|T2]) :- esPar(H), elementos_pares(T, T2).
elementos_pares([H|T], RES) :- esImpar(H), elementos_pares(T, RES).


%8. Generar una lista de hombres filtrando elementos de una lista de personas (que pueden ser
%varones o mujeres: filtraHombres(Xs, Ys). donde Xs es la lista de personas y, Ys es la
%lista de hombres en Xs.

mujer(silvia).
mujer(maria).
mujer(elisa).
mujer(silvina).
mujer(marta).
mujer(alicia).
mujer(paola).
mujer(pamela).
varon(jose).
varon(juan).
varon(jorge).
varon(pedro).
varon(luis).
varon(carlos).
varon(mario).
varon(pablo).

filtraHombres([], []).
filtraHombres([H|T], [H|SALIDA]) :- varon(H), filtraHombres(T,SALIDA).
filtraHombres([H|T], SALIDA) :- mujer(H), filtraHombres(T,SALIDA).

% 9) Define la relaci�n insertado(X, L1s, L2s) de forma que L2s sea una lista obtenida
%    insertando el elemento X en la lista L1s. Usa la relaci�n "elimina" ya definida.
%    ?- insertado(a, [1,2], Ls).
%       Ls = [a, 1, 2] ;
%       Ls = [1, a, 2] ;
%       Ls = [1, 2, a] ;
insertado(X, Xs, Ys) :- elimina(X, Ys, Xs).

% 10) Definir num_a_bin(N, Bs) donde X es un n�mero natural, y Bs es una lista
% compuesta por los d�gitos binarios que lo representan.
num_a_bin(0, [0]).
num_a_bin(1, [1]).
num_a_bin(N, Bs) :- N > 1,
                    RESTO is mod(N, 2),
                    COCIENTE is div(N, 2),
                    num_a_bin(COCIENTE, R),
                    concatenar(R, [RESTO], Bs).
                    
% 11) Definir bin_a_num(Bs, N), que transforme un n�mero binario al n�mero
% natural que representa.
bin_a_num([0], 0).
bin_a_num([1], 1).
bin_a_num([B|Bs], N) :- B =:= 0, bin_a_num(Bs, R), N is R.
bin_a_num([B|Bs], N) :- B =:= 1, longitud(Bs, X), E is X,
                        D is 2 ** E, bin_a_num(Bs, R), N is D + R.


