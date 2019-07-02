:- module(deliverOrder,[]).

:- use_module(transportKnowledge,[]).
:- use_module(transportActions,[]).

%% focus = filter.
%% exit = nogoals.

(   (	goal(delivered_order(C)), bel(ordered(C, P), loc(C, X)), not(bel(in(P, truck))), not(bel(loc(truck, X)))) -> load(P) ; true).

(   (	goal(delivered_order(C)), bel(loc(truck, X), loaded_order(C), loc(C, Y))) -> goto(Y) ; true).

(   (	goal(delivered_order(C)), bel(loc(truck, X), loc(C, X), in(P, truck), ordered(C, P))) -> unload(P) ; true).

(   bel(empty, home(Y)) -> goto(Y) ; true).
