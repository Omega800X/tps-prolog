% Operador y predicado para separar los atributos del operador determina (->)
:-op(740, xfy, ->).
remove_arrow(A -> D, A, D).

% Predicado para convertir atributos a lista de atributos
% Ej: attributes_to_list(abc, X) va a dar como resultado X = [a, b, c]
attributes_to_list(Input, List) :- atom_string(Input, X), string_chars(X, List).

% Predicado que convierte la lista de dependencias en una lista que
% contiene listas de listas.
dependencies_to_lists([Element], Lists) :- remove_arrow(Element, Before, After),
                                            attributes_to_list(Before, R1),
                                            attributes_to_list(After, R2),
                                            append([R1], [R2], Lists).
dependencies_to_lists([H | T], Lists) :- remove_arrow(H, Before, After),
                                           attributes_to_list(Before, R1),
                                           attributes_to_list(After, R2),
                                           append([R1], [R2], DependencyLists),
                                           dependencies_to_lists(T, Result),
                                           append([DependencyLists], [Result], Lists).

% Predicado que permite calcular el cierre de un conjunto de atributos.
% FDs = functional dependencies
% TO-DO
closure_of_set_of_attributes(Set, FDs, Closure).
