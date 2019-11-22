% ITESM QRO
% Mariana Perez Garcia A01206747
% Lab 3

% --------------------------------------------------------------------------
%                               LIMITED DEPTH SEARCH
% --------------------------------------------------------------------------
% Use limited_depth_search(start_node, goal_node, limit, R).
% Example: limited_depth_search(1,2,1,R). => false.
% Example: limited_depth_search(1,2,2,R). => R = [2,1].

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

% creates a stack
stack(E,S,[E | S]).

% checks if stack is empty
empty_stack([]).

% checks if item is a member of the stack
member_stack(E, S):-
  member(E,S).

% Base case to know the size of the stack
get_size([], 0).
% Function to get the size of the stack by iterating the stack and adding a 1
% to the size
get_size([_| S], Size):-
  get_size(S, NewSize),
  Size is NewSize + 1.

% Function that performs the limited depth search by using the Start variable as
% a number where the search is going to start, Goal is a value of the wanted Goal
% Limit is a number that states the max limit of the search, and R is going to return
% the stack of the path from Start to Goal
limited_depth_search(Start, Goal, Limit, R):-
  empty_stack(Empty_been_list),
  stack(Start, Empty_been_list, Been_List), % Creates a stack and adds the first element (Start) to the stack
  path(Start, Goal, Been_List, Limit, R). % Calls the function to check the paths

% Base case where the Start is Equal to the goal, stating that the goal has been reached
% And returns the stack of the path from Start to Goal
path(Goal, Goal, R, _, R).

path(State, Goal, Been_List, Limit, R):-
  mov(State, Next), %Checks the next possible element from the current state
  not(member_stack(Next, Been_List)), % checks if the next element is not already in the stack meaning that it has not been visited
  stack(Next, Been_List, New_been_list), % if the next node has not been visited then add it to the stack
  get_size(New_been_list, Size), % Get the stack size
  Size =< Limit, % And check if the stack size is smaller or equal to the wanted limit
  path(Next, Goal, New_been_list,Limit, R), % If the stack is smaller than the limit then continue with the next node
  !. % Stop backtracking

% --------------------------------------------------------------------------
%                                    QUICKSORT
% --------------------------------------------------------------------------
% Example: quick_sort([]). => [].
% Example: quick_sort([20]). => [20].
% Example: quick_sort([13, 46, 25, 12, 27, 1], X). => X = [1, 12, 13, 25, 27, 46].

% Base case where the given list is empty
quick_sort([],[]).
% Base case when the list only contains one element
quick_sort([X], [X]).
% Function quick_sort that receives as input a list of numbers, and a variable to
% give the result.
quick_sort([Head | Tail], Sorted):-
  divide(Tail, Head, Left, Right), %Function that divides the list into two list a right and left side
  quick_sort(Left, Ls), % Use recursion to do the same for the left side
  quick_sort(Right, Rs), % Use recursion to do the same for the right side
  append(Ls, [Head | Rs], Sorted). % Append the left side to the pivot (Head) and the right side
  % Because once it already divided the list the pivot is in its final position.

% Function that receives a list of numbers, the first element of the given list
% will be used as a pivot, because in quicksort we can use whatever element as a pivot
% then it will compare all the elements in the given list to the pivot and if they are
% bigger than the pivot then thay will be on the right side other wise in the left side
divide([], _, [], []).
divide([Head | Tail], Pivot, [Head | Ls], Rs):-
  Head =< Pivot, % If head is smaller or equal to pivot add it to the left
  divide(Tail, Pivot, Ls, Rs).
divide([Head | Tail], Pivot, Ls, [Head | Rs]):-
  Head > Pivot, % If head is bigger than pivot add it to the right
  divide(Tail, Pivot, Ls, Rs).
