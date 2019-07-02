:- module(initScriptCounter,[]).

:- use_module(counterKnowledge,[]).

true -> insert( nrOfPrintedLines(0) ) + adopt( nrOfPrintedLines(11) ).
