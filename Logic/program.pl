appeared_together(Actor1, Actor2):-
  appear(Film, Actor1),
  appear(Film, Actor2).

appear(los_mercenarios, chuck_norris).
appear(el_furor_del_dragon, chuck_norris).
appear(karate_kid, jackie_chan).
appear(who_am_i, jackie_chan).
appear(el_furor_del_dragon, bruce_lee).
appear(operacion_dragon, bruce_lee).
