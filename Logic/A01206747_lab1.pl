hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

compatible(X, Y):-
  hobby(X, Hobby),
  hobby(Y, Hobby).


on_route(roma).
on_route(Place):-
  road(Place, NewPlace),
  on_route(NewPlace).


road(placentia, ariminum).
road(ariminum, ancona).
road(ariminum, roma).
road(ancona, castrum).
road(castrum, roma).
road(ancona, roma).
road(placentia, genua).
road(genua, pisae).
road(genua, roma).
road(pisae, roma).
road(capua, roma).
road(brundisium, capua).
road(messana, capua).
road(rhegium, messana).
road(catina, messana).
road(syracusae, catina).
road(lilibeum, messana).

can_get_to(Origin, Destination):-
  road(Origin, Destination).

can_get_to(Origin, Destination):-
  road(Origin, Z),
  can_get_to(Z, Destination).

size(X, Y, Z):-
  road(X, Y), Z is 1.

size(X, Y, Z):-
  road(X, M),
  size(M, Y, N),
  Z is N + 1.

min(A, B, C, Z):-
  A = B, B = C, Z is A;
  A < B, B = C, Z is A;
  A > B, A = C, Z is B;
  A = B, A > C, Z is C;
  A < B, B < C, Z is A;
  A > B, B < C, Z is B;
  A < B, B > C, Z is A;
  A > B, B > C, Z is C.

sum(X, Y, Z):-
  Z is X+Y.

predicate(Z, 0, Z).

predicate(A, B, Z):-
  C is A mod B,
  predicate(B, C, Z).
