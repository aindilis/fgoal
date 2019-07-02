:- module(updateCounter,[]).

:- use_module(fgoal_utils).

:- use_module(counterKnowledge).

init :-
	(   (	bel( nrOfPrintedLines(Count)), NewCount is Count + 1) ->
	    delete( nrOfPrintedLines(Count) ) ++ insert( nrOfPrintedLines(NewCount) ) ;
	    true).
	

