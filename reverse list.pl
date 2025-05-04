% Base case: the reverse of an empty list is an empty list.
reverse_list([], []).

% Recursive case: reverse tail, then append head at the end.
reverse_list([H|T], R) :-
    reverse_list(T, RT),
    append(RT, [H], R).

% Initialization to test the reverse
:- initialization(main).

main :-
    L = [1, 2, 9, 4],
    reverse_list(L, R),
    format("Original list: ~w~n", [L]),
    format("Reversed list: ~w~n", [R]),
    halt.
