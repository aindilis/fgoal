:- module(updateScriptCounter,[]).

:- use_module(counterKnowledge,[]).

(   percept( printedText(NewCount) ), bel( nrOfPrintedLines(Count) )) -> delete( nrOfPrintedLines(Count) ) + insert( nrOfPrintedLines(NewCount) ).
