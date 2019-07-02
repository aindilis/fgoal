:- module(transportModules,[]).

% you can always go home
(   bel(home(X)) -> goto(X) ; true).

(   goal(delivered_order(C)) -> deliverOrder ; true).
