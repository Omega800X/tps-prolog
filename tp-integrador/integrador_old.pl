% Operador y predicado para separar los atributos del operador determina (->)
:-op(740, xfy, ->).
remove_arrow(A -> D, A, D).

% Predicado para convertir atributos a lista de atributos
% Ej: attributes_to_list(abc, X) va a dar como resultado X = [a, b, c]
attributes_to_list(Input, List) :- atom_string(Input, X), string_chars(X, List).

% Predicado que convierte una dependencia funcional en una lista de listas.
dependency_to_lists(Dependency, [Result]) :- remove_arrow(Dependency, Before, After),
                                         attributes_to_list(Before, List1),
                                         attributes_to_list(After, List2),
                                         append([List1], [List2], Result).

% Predicado que convierte la lista de dependencias en una lista que
% contiene listas de listas.
dependencies_to_lists([Dependency], Lists) :- dependency_to_lists(Dependency, Lists).
dependencies_to_lists([H | T], Lists) :- dependency_to_lists(H, Aux1),
                                         dependencies_to_lists(T, Aux2),
                                         append(Aux1, Aux2, Lists).

% Predicado que permite calcular el cierre de un conjunto de atributos.
% FDs = functional dependencies
closure_of_set_of_attributes(Set, [], Set).
closure_of_set_of_attributes(Set, [H | T], Closure) :- nth0(0, H, X),
                                                       nth0(1, H, Y),
                                                       subset(X, Set),
                                                       union(Set, Y, NewSet),
                                                       closure_of_set_of_attributes(NewSet, T, Aux),
                                                       union(Set, Aux, Closure).
closure_of_set_of_attributes(Set, [H | T], Closure) :- nth0(0, H, X),
                                                       \+subset(X, Set),
                                                       closure_of_set_of_attributes(Set, T, Closure).




printDep(Dep, Result):- write(Dep).

original_set([], _, _):- write('}').
original_set([DepCab | DepCola], _):- write("{"),
                                               printDep(DepCab, Dep, Result),
                                               original_set(DepCola, _, _).
original_set([DepCab | DepCola], _, _):- write(","),
                                                printDep(DepCab, Dep, Result),
                                                original_set(DepCola, _, _).



