% Grammar: S → a S b | ε
s --> [].
s --> [a], s, [b].

% Entry point to test the grammar
accept(List) :-
    phrase(s, List).

% Initialization: check if [a,a,b,b] is in the language
:- initialization(main).

main :-
    Test = [a,a,b,b,b],
    (accept(Test) ->
        format("~w is in the language a^n b^n~n", [Test]);
        format("~w is NOT in the language a^n b^n~n", [Test])
    ),
    halt.
