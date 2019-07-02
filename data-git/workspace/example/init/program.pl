:- module(program,[]).

forall(bel(percept(zone(ID, Name, X, Y, Neighbours))),insert(zone(ID, Name, X, Y, Neighbours))).

forall(bel(percept(state(State))),insert(state(State))).

forall(bel(percept(sequence(T))),adopt(sequence(T)) + bAnalyst.send(sequence(T))).

forall(bel(percept(at(X))),insert(at(X))).
