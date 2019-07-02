:- module(counterKnowledge,[]).

:- use_module(fgoal_knowledge,[]).

% Declaration of a predicate for counting the number of printed lines.
:- dynamic nrOfPrintedLines/1.
