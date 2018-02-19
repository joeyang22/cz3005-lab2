person(bob).
person(robert).
person(fred).
brother(bob, robert).
brother(robert, fred).
sibling(X,Z):- brother(X, Y), brother(Y, Z).
