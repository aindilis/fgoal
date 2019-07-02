:- module(initCounter,[]).

:- use_module(fgoal_utils).

:- use_module(counterKnowledge).

init :-
	(   true -> insert( nrOfPrintedLines(0) ) ++ adopt( nrOfPrintedLines(10) ) ; true).

