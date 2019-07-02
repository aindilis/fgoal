:- module(printScript,[]).

:- use_module(counterKnowledge,[]).
:- use_module(scriptBeliefs,[]).
:- use_module(printTextActionspec,[]).

%% exit=nogoals.

(   goal( nrOfPrintedLines(_) ), bel( nrOfPrintedLines(LineNr), NextLine is LineNr+1, script(NextLine, Text) )) ->  printText(Text).
