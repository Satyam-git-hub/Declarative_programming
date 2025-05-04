% Base case: appending an empty list to L yields L
conc([], L, L).

% Recursive case: append Head of L1 to the result of appending Tail
conc([H|T], L2, [H|R]) :-
    conc(T, L2, R).

% Initialization: test the conc predicate
:- initialization(main).

main :-
    L1 = [1, 2],
    L2 = [3, 4],
    conc(L1, L2, L3),
    format("List 1: ~w~n", [L1]),
    format("List 2: ~w~n", [L2]),
    format("Concatenated List: ~w~n", [L3]),
    halt.
