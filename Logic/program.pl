appeared_together(Actor1, Actor2):-
  appear(Film, Actor1),
  appear(Film, Actor2).

appear(los_mercenarios, chuck_norris).
appear(el_furor_del_dragon, chuck_norris).
appear(karate_kid, jackie_chan).
appear(who_am_i, jackie_chan).
appear(el_furor_del_dragon, bruce_lee).
appear(operacion_dragon, bruce_lee).


dad(billy, bob).
dad(bob, sue).
dad(bob, alex).
dad(john, pete).
dad(alex, john).
dad(pete, jack).
mom(ana, erika).
mom(sue, sussy).
mom(ana, billy).

grandparent(X, Z):-
  dad(X,Y),
  dad(Y,Z);
  mom(X,Y),
  mom(Y,Z).

ancestor_male(Ancestor, Descendant):-
  dad(Ancestor, Descendant).

ancestor_male(Ancestor, Descendant):-
  dad(Ancestor, X),
  ancestor_male(X, Descendant).

ancestor(Ancestor, Descendant):-
  dad(Ancestor, Descendant);
  mom(Ancestor, Descendant).

ancestor(Ancestor, Descendant):-
  dad(Ancestor, X),
  ancestor(X, Descendant);
  mom(Ancestor, Y),
  ancestor(Y, Descendant).


% House Lannister
dad(twyin, tyron).
mom(joanna, tyron).
dad(twyin, cersei).
mom(joanna, cersei).
dad(twyin, jaime).
mom(joanna, jaime).
dad(twyin, tyron).
mom(joanna, tyron).
dad(robert, joffrey).
mom(cersei, joffrey).
dad(robert, myrcella).
mom(cersei, myrcella).
dad(robert, tomen).
mom(cersei, tomen).
dad(joffrey, empty).
mom(myrcella, empty).
dad(tomen, empty).

next_heir(Ancestor, Heir):-
  dad(Ancestor, Heir),
  dad(Heir, empty).

next_heir(Ancestor, Heir):-
  dad(Ancestor, Kid),
  next_heir(Kid, Heir);
  mom(Ancestor, Kid),
  next_heir(Kid, Heir).
