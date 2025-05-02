move(1, Source, Destination, _) :-
    format('Move disssk 1 from ~w to ~w~n', [Source, Destination]).

move(N, Source, Destination, Auxiliary) :-
    N > 1,
    M is N - 1,
    move(M, Source, Auxiliary, Destination),
    format('Move disk ~d from ~w to ~w~n', [N, Source, Destination]),
    move(M, Auxiliary, Destination, Source).

tower_of_hanoi(N) :-
    move(N, left, right, center).

:- initialization(tower_of_hanoi(2)).
