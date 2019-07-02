:- module(fgoal_utils,
	  [
	   op( 1000, xfy, [ '++' ]),
	   '++'/2,
	   insert/1,
	   delete/1,
	   bel/1,
	   goal/1,
	   adopt/1,
	   drop/1
	  ]).

:- use_module(fgoal_beliefs).
:- use_module(fgoal_goals).

:- op( 1000, xfy, [ '++' ]).

'++'(X,Y) :-
	call(X), call(Y).
