% Graph definition
edge(a, b, 1).
edge(a, c, 3).
edge(b, d, 1).
edge(c, d, 1).
edge(d, e, 1).

% Heuristic values
heuristic(a, 5).
heuristic(b, 3).
heuristic(c, 2).
heuristic(d, 1).
heuristic(e, 0).

% Entry point for Best-First Search
best_first(Start, Goal, Path) :-
    bestfs([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

% When goal is reached
bestfs([[Goal | Rest] | _], Goal, [Goal | Rest]).

% Continue search
bestfs([CurrentPath | OtherPaths], Goal, FinalPath) :-
    CurrentPath = [CurrentNode | PathTail],
    findall(
        [Next, CurrentNode | PathTail],
        (edge(CurrentNode, Next, _), \+ member(Next, CurrentPath)),
        NewPaths
    ),
    append(OtherPaths, NewPaths, AllPaths),
    sort_by_heuristic(AllPaths, SortedPaths),
    bestfs(SortedPaths, Goal, FinalPath).

% Sort list of paths by heuristic value of head node (simple insertion sort)
sort_by_heuristic([], []).
sort_by_heuristic([Path | Rest], Sorted) :-
    sort_by_heuristic(Rest, SortedRest),
    insert_by_heuristic(Path, SortedRest, Sorted).

insert_by_heuristic(Path, [], [Path]).
insert_by_heuristic(Path, [H | T], [Path, H | T]) :-
    path_heuristic(Path, HP),
    path_heuristic(H, HH),
    HP =< HH.
insert_by_heuristic(Path, [H | T], [H | SortedTail]) :-
    path_heuristic(Path, HP),
    path_heuristic(H, HH),
    HP > HH,
    insert_by_heuristic(Path, T, SortedTail).

% Heuristic value for head of path
path_heuristic([Node | _], H) :-
    heuristic(Node, H).

% Initialization to run on file load
:- initialization(run_best_first).

run_best_first :-
    best_first(a, e, Path),
    write('Best-First Search Path from a to e: '), write(Path), nl.
