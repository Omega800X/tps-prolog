% Predicados para eliminar la flecha
:- op(740, xfy, ->).
eliminarFlecha(LadoIzq -> LadoDer, LadoIzq, LadoDer).

% Predicado para convertir atributos en forma de átomo a una lista de atributos
% Ej: abc en [a, b, c]
atributosEnLista(Entrada, Lista) :- atom_string(Entrada, Cadena),
                                    string_chars(Cadena, Lista).

% Predicados para convertir las dependencias funcionales en listas de listas.
convertirDependencia(Entrada, Salida) :- eliminarFlecha(Entrada, LadoIzq, LadoDer),
                                         atributosEnLista(LadoIzq, LI),
                                         atributosEnLista(LadoDer, LD),
                                         append([LI], [LD], Salida).
convertirDependencias([Dependencia], [Salida]) :- convertirDependencia(Dependencia, Salida).
convertirDependencias([Cab | Cola], Salida) :- convertirDependencia(Cab, LC),
                                               convertirDependencias(Cola, S),
                                               append([LC], S, Salida).

% Predicado para fusionar reglas con mismo lado izquierdo
fusionarLadosIzquierdos([], []).
fusionarLadosIzquierdos([[X, Y] | T], [[X, Z1] | R]) :-
  findall(LadoDer, (member([X, LadoDer], T)), LadosDers),
  append([Y | LadosDers], Z),
  sort(Z, Z1),
  exclude(=([X, _]), T, T1),
  fusionarLadosIzquierdos(T1, R).
  

% Predicados para calcular la clausura de un conjunto de atributos.
obtenerDeterminaciones(X, DFs, Xmas) :-
   findall(A, (member([M, A], DFs), subset(M, X)), As),
   flatten(As, AsF),
   sort(AsF, AsFinal),
   union(X, AsFinal, Xmas).

clausura([], _, []).
clausura(X, DFs, Xmas) :-
            obtenerDeterminaciones(X, DFs, Xr),
            X = Xr,
            Xmas = Xr.
clausura(X, DFs, Xmas) :-
            obtenerDeterminaciones(X, DFs, Xr),
            X \= Xr,
            clausura(Xr, DFs, Xmas).
            
% Predicados para calcular el conjunto cerrado en atributos.
obtenerLadosIzqsDFs(DFs, R) :-
        findall(LI, (member([LI, _], DFs)), R).

conjuntoCerradoEnAtributos([], _, []).
conjuntoCerradoEnAtributos(LIs, DFs, R):-
        nth0(0, LIs, Conj),
        clausura(Conj, DFs, Ci),
        exclude(=(Conj), LIs, LIs2),
        append([Conj], [Ci], Ri),
        conjuntoCerradoEnAtributos(LIs2, DFs, Ri2),
        append([Ri], Ri2, R).


db(DFs, Atributos) :-
        convertirDependencias(DFs, DFsListas),
        writeln("Lista de listas (DFs):"),
        writeln(DFsListas),
        atributosEnLista(Atributos, AtribLista),
        writeln("Atributos en forma de lista:"),
        writeln(AtribLista),
        fusionarLadosIzquierdos(DFsListas, DFsFin),
        writeln("Lados izquierdos fusionados:"),
        writeln(DFsFin),
        obtenerLadosIzqsDFs(DFsFin, LIs),
        writeln("Lados izquierdos únicos:"),
        writeln(LIs),
        conjuntoCerradoEnAtributos(LIs, DFsFin, Resultado),
        writeln("Conjunto cerrado en atributos (formato lista):"),
        writeln(Resultado),
        conjuntoAFormatoLegible(Resultado, P),
        writeln("Conjunto cerrado en atributos:"),
        write(P).

% Predicados para imprimir conjuntos
listaAAtributos(Lista, Atributos) :-
  atomics_to_string(Lista, String),
  atom_string(Atributos, String).

agregarFlecha(LadoIzq, LadoDer, LadoIzq -> LadoDer).

listaAAtomo([H, T], Res) :-
                   sort(H, HS),
                   sort(T, TS),
                   listaAAtributos(HS, R1),
                   listaAAtributos(TS, R2),
                   agregarFlecha(R1, R2, Res).

conjuntoAFormatoLegible([H], [R]) :-
                             listaAAtomo(H, R).
conjuntoAFormatoLegible([H | T], R) :-
                listaAAtomo(H, Ri),
                conjuntoAFormatoLegible(T, Rii),
                append([Ri], Rii, R).
