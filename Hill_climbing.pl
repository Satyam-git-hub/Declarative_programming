% Sample problem domain:
% State: an integer
% Goal: find the highest value under some constraint

% Define neighbors of a state
neighbor(X, Y) :-
    Y is X + 1;
    Y is X - 1.

% Define a heuristic function (to be maximized)
heuristic(X, H) :-
    H is -1 * (X - 5) * (X - 5) + 25.  % max at X=5

% Hill climbing: core logic
hill_climb(Current, _, Current) :-
    findall(H, (neighbor(Current, N), heuristic(N, H), heuristic(Current, HC), H > HC), []),
    !.  % No better neighbor: stop (local maximum)

hill_climb(Current, Path, Result) :-
    findall(
        H-N,
        (neighbor(Current, N), heuristic(N, H)),
        HNList
    ),
    sort(HNList, Sorted),         % sort ascending
    reverse(Sorted, [BestH-BestN | _]),  % best is now head
    heuristic(Current, HC),
    BestH > HC,
    hill_climb(BestN, [BestN | Path], Result).

% Wrapper
start_hill_climb(Init) :-
    hill_climb(Init, [Init], Result),
    format('Reached local maximum at ~w~n', [Result]).
    
:- initialization(start_hill_climb(1)).
