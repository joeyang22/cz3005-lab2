ask(slides, 0).

/* Ask followups for a given action, and then related queries */
ask(X, Y):- action(Y), followup(X, Y).
ask(X, Y):- action(Y), related(X, Y).
ask(X, Y):- random(X).

member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

eat_member(X, [X|_]).
eat_member(X, [_|R]) :- eat_member(X, R)

takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

append([A | B], C, [A | D]) :- append(B, C, D).
append([], A, A).

related(X,Y) :-
	play(L), member(X, L), member (Y, L);
	eat(L), member(X, L), member (Y, L);
	do(L), member(X, L), member (Y, L);
	see(L), member(X, L), member (Y, L);
	learn(L), member(X, L), member (Y, L);

followup(X,Y) :- eat(L), eat_member(X, L), eat_member(Y, L).
/* followup(X,Y) :- play(L), member(X, L), play_followup(Y, L).
followup(X,Y) :- learn(L), member(X, L), learn_followup(Y, L). */

play([slides, sandbox, toys, trains, cars, playmat, build, bears,, alphabet, numbers, ball]).
eat([cake, toffee, candy, sandwich, pizza, cheerios, veggies, fries, hamburgers, chocolate]).
do([build, veggies, trains, draw, blocks, sandbox, cars]).
see([cake, candy, alphabet, draw, playmat]).
learn([alphabet, numbers, blocks, draw]).

play_followup([tiring, fun, exciting, hard]).
eat_followup([fork, spoon, hands]).
learn_followup([understand, good]).

a.
action(nothing).
a.
