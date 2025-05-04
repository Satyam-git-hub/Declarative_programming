% Grammar rules with parse tree output
sentence(s(NP, VP)) --> noun_phrase(NP), verb_phrase(VP).

noun_phrase(np(Det, N)) --> determiner(Det), noun(N).
verb_phrase(vp(V, NP)) --> verb(V), noun_phrase(NP).

determiner(det(the)) --> [the].
determiner(det(a))   --> [a].

noun(n(cat))  --> [cat].
noun(n(dog))  --> [dog].
noun(n(mouse))--> [mouse].

verb(v(chased)) --> [chased].
verb(v(saw))    --> [saw].
verb(v(bitten)) --> [bitten].

% Entry point predicate
parse_sentence(Tree, Sentence) :-
    phrase(sentence(Tree), Sentence).

% Initialization directive: run this on load
:- initialization(main).

main :-
    Sentence = [the, cat, chased, a, mouse],
    ( parse_sentence(Tree, Sentence) ->
        format("Parse tree for ~w:~n~w~n", [Sentence, Tree])
    ; 
        format("Failed to parse sentence: ~w~n", [Sentence])
    ),
    halt.
