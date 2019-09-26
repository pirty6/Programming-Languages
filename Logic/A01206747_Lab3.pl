% ITESM QRO
% Mariana Perez Garcia A01206747
% Lab 3

%limited_depth_search()
% graph
mov(1,2).
mov(1,3).
mov(1,4).
mov(2,5).
mov(2,6).
mov(2,7).
mov(3,8).
mov(3,9).
mov(3,6).
mov(4,5).
mov(4,7).
mov(4,11).
mov(4,9).
mov(7,8).
mov(7,10).
mov(8,9).

stack(E,S,[E | S]).
empty_stack([]).
member_stack(E, S):-
  member(E,S).

go(Start, Goal, R):-
  empty_stack(Empty_been_list),
  stack(Start, Empty_been_list, Been_List),
  path(Start, Goal, Been_List, R).

path(Goal, Goal, R, R).

path(State, Goal, Been_List, R):-
  mov(State, Next),
  not(member_stack(Next, Been_List)),
  stack(Next, Been_List, New_been_list),
  path(Next, Goal, New_been_list, R),
  !.
