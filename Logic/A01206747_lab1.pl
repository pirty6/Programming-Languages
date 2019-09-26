% ITESM QRO
% Mariana Perez Garcia A01206747
% Lab 3

% facts about hobbies
hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

% Function that returns true if X and Y are compatible
% if they share the same hobby. Otherwise false
compatible(X, Y):-
  hobby(X, Hobby),
  hobby(Y, Hobby).
% Example: compatible(juan, simon) = true

% facts about roads
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

% Function that returns true if there is
% a path that starts in Origin and following
% the directionality if the roads can get
% to Destination
can_get_to(Origin, Destination):-
  road(Origin, Destination).

can_get_to(Origin, Destination):-
  road(Origin, Z),
  can_get_to(Z, Destination).
% Example: can_get_to(lilibeum, capua) = true


% Function that returns in Z the number of cities
% crossed in the path from X to Y.
size(X, Y, 0):-
  road(X, Y).

size(X, Y, Z):-
  road(X, M),
  size(M, Y, N),
  Z is N + 1.
% Example: size(lilibeum, capua, Z) = 1


% Function that returns Z as the minimal value
% between A, B, and C.
min(A, B, C, Z):-
  A = B, B = C, Z is A;
  A < B, B = C, Z is A;
  A > B, A = C, Z is B;
  A = B, A > C, Z is C;
  A < B, A < C, Z is A;
  A > B, B < C, Z is B;
  A < B, A > C, Z is C;
  A > B, B > C, Z is C;
  A = B, B < C, Z is B;
  A = C, C < B, Z is C;
  B = C, C < A, Z is C.
% Example: min(1,2,3,Z) = 1

% Function that returns Z as the gratest
% common divisor
gdc(Z, 0, Z).

gdc(A, B, Z):-
  C is A mod B,
  gdc(B, C, Z).
% Example: gdc(48, 18) = 6
