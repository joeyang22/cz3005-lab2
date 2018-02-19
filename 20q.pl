/* Create the knowledge base with defining features for each game */
badminton([doubles, singles, indoor, court, twoTeams, racket, shuttlecock, win]).
tennis([doubles, singles, outdoor, court, twoTeams, racket, ball, win]).
diving([singles, indoor, pool, manyTeams, water, score]).
trackAndField([singles, outdoor, field, manyTeams, time]).
basketball([team, indoor, court, twoTeams, ball, win]).
tableTennis([doubles, singles, indoor, court, twoTeams, racket, ball, win]).
volleyball([team, indoor, court, twoTeams, ball, win]).
gymnastics([singles, indoor, court, manyTeams, score]).
swimming([singles, indoor, pool, manyTeams, water, time]).
handball([team, indoor, court, twoTeams, ball, win]).

/* Counter */
counter(C).

/* Initializing game */
selected(tennis).

/* Flatten list to get options */
all_options(L):- flatten([badminton(X),tennis(X),diving(X),trackAndField(X),basketball(X), tableTennis(X), volleyball(X), gymnastics(X), swimming(X), handball(X)], L).

flatten(List, FlatList) :-
flatten(List, [], FlatList0),!,FlatList = FlatList0.
flatten(Var, Tl, [Var|Tl]) :- var(Var),!.
flatten([], Tl, Tl) :- !.
flatten([Hd|Tl], Tail, List) :-
  !,
  flatten(Hd, FlatHeadTail, List),
  flatten(Tl, Tail, FlatHeadTail).
flatten(NonList, Tl, [NonList|Tl]).
