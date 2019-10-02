% ITESM QRO
% Mariana Perez Garcia A01206747
% Lab 3

% Function that recieves a list and returns true if at least one element in the
% list is positive, otherwise it returns false.
any_positive([Head | Tail]):-
  Head > 0;
  Head < 0,
  any_positive(Tail).
% Example: any_positive([-1,-2,3,-4]). = true

% Function that receives an X value, a Y value a list and an empty variable
% The function then iterates throughout the list and every element that is equal
% to X is change into the X value otherwise the value stays the same,
% the function returns in the empty variable a new list with the new values.
substitute(_, _, [], []). % Base case where the list is empty

substitute(X, Y, [X | Tail], [Y | Result]):- % If the head of the list is equal to X then append to the result the Y value
  substitute(X, Y, Tail, Result).

substitute(X, Y, [Head | Tail], [Head | Result]):- % If the head of the list is not equal to X then append head to the result
  substitute(X, Y, Tail, Result).
% Example: substitute(2, 3, [1, 2, 2, 2, 3, 2], X). => X = [1, 3, 3, 3, 3, 3]

% Function that receives a list and a variable that iterates through the list and checks if
% if the head of the list is a member of the result varible if it is a member then it is not
% added to the list otherwise it is added to the result list.
eliminate_duplicates([],[]). % Base case where the list is empty

eliminate_duplicates([Head | Tail],[Head |Result]):- % Iterates through the list and append head if it is not a member
  eliminate_duplicates(Tail , Result),
  not(member(Head ,Result)).

eliminate_duplicates([Head | Tail], Result):- % Iterates through the list and remove head if it is already in result
  eliminate_duplicates(Tail , Result),
  not(member(Head , Result)).
% Example: eliminate_duplicates([a, a, a, a, b, c, c, a, a, d, e, e, e, e],X). => X = [a, b, c, d, e]

% Function that receives two lists and a variable and it iterates through the first list
% and check if its head is a member of the second list, if that statement is true, then add the
% Head to the resulting list otherwise discard the head and continue iterating.
intersect([], _, []). % Base case where the first list is empty, the second list doesn't matter and the result is empty.

intersect([Head | Tail], List, [Head | Result]):- % If the head of the first list is a member of the second list add it to result.
  member(Head , List),
  intersect(Tail, List, Result).

intersect([_ | Tail], List, Result):- % Else discard it, and continue with the next element.
  intersect(Tail, List, Result).
% Example: intersect([a, b, c, d], [b, d, e, f], X). => X = [b, d]

% Function that receives a list and a variable and returns the list in inverse order by appending the head
% at the start of a new list, and then it will continue iterating the list. The new list will then
% be then the result of the function.
invert([], []). % Base case where both lists are empty.

invert([Head | Tail], Result):-
  append(New_List, [Head], Result),
  invert(Tail, New_List).
% Example: invert([a, b, e, c, e],X). => X = [e, c, e, b, a]

% Function that receives a value X, a list and a variable and it iterates through the list and
% adds the head of the list to the result only if it is less than the given value X.
less_than(_, [], []). % Base case where it doesn't matter the X value, but the two lists are empty

less_than(X, [Head | Tail], [Head | Result]):- % If the head is less than X add it to the result.
  Head < X,
  less_than(X, Tail, Result).

less_than(X, [_|Tail], Result):- % Else continue with the next element.
  less_than(X, Tail, Result).
% Example: less_then(5, [1, 6, 5, 2, 7], X). => X = [1, 2]

% Function that receives a value X, a list and a variable and it iterates through the list and
% adds the head of the list to the result if it is bigger or equal to the given X value.
more_than(_, [], []). % Base case where it doesn't matter the X value, but the two lists are empty.

more_than(X, [Head | Tail], [Head | Result]):- % If the head is bigger or equal to X.
  Head > X,
  more_than(X, Tail, Result);
  Head = X,
  more_than(X, Tail, Result).

more_than(X, [_ | Tail], Result):- % Else discard the head and continue with the next element.
  more_than(X, Tail, Result).
% Example: more_than((5, [1, 6, 5, 2, 7], X). => X = [6, 5, 7]

% Function that receives a list, a value X and a variable and then it rotates all the elements of the
% given list the X spaces. The function is divided into two functions where one is in charge of rotating the
% list if X is a positive number, and the other if it is a negative number. To achive this the head is appended to the tail
% X times.
rotate(List, 0, List). % Base case

rotate([ Head | Tail], X, Result):- % If X is bigger than 0 then append the head to the tail and continues until X = 0
  X > 0,
  N is X - 1,
  append(Tail, [Head], NewList),
  rotate(NewList, N, Result).

rotate(Tail, X, Result):- % If X is smaller than 0 then call the rotate function again with X = -X
  X < 0,
  N is -X,
  rotate(Result, N, Tail).
% Example: rotate([1, 6, 5, 2, 7], 3, X). => X = [2, 7, 1, 6, 5]
% Example: rotate([1, 6, 5, 2, 7], -3, X). => X = [5, 2, 7, 1, 6]

% facts about roads, where all roads are bidirectional
road(placentia, ariminum).
road(ariminum, placentia).
road(ariminum, ancona).
road(ancona, ariminum).
road(ariminum, roma).
road(roma, ariminum).
road(ancona, castrum).
road(castrum, ancona).
road(castrum, roma).
road(roma, castrum).
road(ancona, roma).
road(roma, ancona).
road(placentia, genua).
road(genua, placentia).
road(genua, pisae).
road(pisae, genua).
road(genua, roma).
road(roma, genua).
road(pisae, roma).
road(roma, pisae).
road(capua, roma).
road(roma, capua).
road(brundisium, capua).
road(capua, brundisium).
road(messana, capua).
road(capua, messana).
road(rhegium, messana).
road(messana, rhegium).
road(catina, messana).
road(messana, catina).
road(syracusae, catina).
road(catina, syracusae).
road(lilibeum, messana).
road(messana, lilibeum).

% Function that receives a city of origin, a destiny city and a varible and returns a list
% of the cities passed to go from the origin to the destination. The function uses a helper
% function that passes all the values and the origin city as a list to a function called path_to
path(Origin, Destiny, Path):-
  path_to(Origin, Destiny, [Origin], Path).

path_to(Origin, Destiny, Route, Path):- % If there is a path between the origin and destination and the destination is not a member
  road(Origin, Destiny),                % of the list then append the destination to the list and call the function path_to again.
  not(member(Destiny, Route)),
  append(Route, [Destiny], NewRoute),
  path_to(Origin, Destiny, NewRoute, Path).

path_to(Origin, Destiny, Route, Route):- % Base case, where there is a path between origin and destination and the destination is a
  road(Origin, Destiny),                 % member of the list then end
  member(Destiny, Route).

path_to(Origin, Destiny, Route, Path):- % check recursively to other city to find a path, if the new destiny is not a part of the list
  road(Origin, AnotherDestiny),         % then append the element to the list.
  not(member(AnotherDestiny, Route)),
  append(Route,[AnotherDestiny], NewRoute),
  path_to(AnotherDestiny, Destiny, NewRoute, Path).
% Example: path(placentia, roma, Path). => Path = [placentia, ariminum, roma] .
% Example: path(brundisium, genua, Path). => Path = [brundisium, capua, roma, genua]
