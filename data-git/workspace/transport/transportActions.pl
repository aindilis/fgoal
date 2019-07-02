modules(transportActions,[]).

load(P) :-
	pre(not(packed), loc(truck,X), loc(P,X)),
	post(in(P,truck), not(loc(P,X))).

goto(Y) :-
	pre(loc(truck,X), not(X=Y)),
	post(loc(truck,Y), not(loc(truck,X))).

unload(P) :-
	pre(in(P,truck), loc(truck,X)),
	post(loc(P,X), not(in(P,truck))).
