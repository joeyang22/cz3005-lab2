ask(slides, 0).
/* Ask for an item that is related to the liked item first before going to a random
 	 item, but make sure you don't ask a previously asked question. */
ask(X,Y):-
	like(Y), related(X,Y), \+ history(X).
ask(X,Y):-
	random(X), \+ related(X,Y), \+ history(X).
ask(X,Y):-
	random(X), \+ history(X).

/* Determines if X is part of a list */
member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

/* Adds element to a list */
append([A | B], C, [A | D]) :- append(B, C, D).
append([], A, A).

/* Define relationships of two different items */
related(X,Y) :-
	play(L), member(X, L), member(Y, L);
	eat(L), member(X, L), member(Y, L);
	do(L), member(X, L), member(Y, L);
	see(L), member(X, L), member(Y, L);
	learn(L), member(X, L), member(Y, L).

/* Define the relationship between a member of each list and their followup question */
followup(X, Y) :-
	play(L), member(X, L), play_followup(Y);
	eat(L), member(X, L), eat_followup(Y);
	do(L), member(X, L), do_followup(Y);
	see(L), member(X, L), see_followup(Y);
	learn(L), member(X, L), learn_followup(Y).

/* Create the random list */

random(X) :-
	play(L), member(X, L);
	eat(L), member(X, L);
	do(L), member(X, L);
	see(L), member(X, L);
	learn(L), member(X, L).

/* Create the list of items for each category */
play([slides, sandbox, toys, trains, cars, playmat, build, bears, alphabet, numbers, ball]).
eat([cake, toffee, candy, sandwich, pizza, cheerios, veggies, fries, hamburgers, chocolate]).
do([build, veggies, trains, draw, blocks, sandbox, cars]).
see([cake, candy, alphabet, draw, playmat]).
learn([alphabet, numbers, blocks, draw]).

/* Keep a list of standard followup questions for each category */
play_followup(fun).
eat_followup(tasty).
see_followup(cool).
learn_followup(interesting).
do_followup(enjoyable).

/* Initialize the like, dislike, and history */
like(nothing).
dislike(nothing).
history(nothing).
a.
