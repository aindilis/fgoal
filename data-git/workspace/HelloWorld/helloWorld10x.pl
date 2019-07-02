:- module(helloWorld10x,[]).

:- use_module(fgoal_utils).

:- use_module(counterKnowledge).

%% exit=nogoals.

init :-
	(   goal( nrOfPrintedLines(_) ) -> (print("Hello, world!"),nl) ; true).
