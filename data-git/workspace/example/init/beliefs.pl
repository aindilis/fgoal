:- module(beliefs,[]).

%remainingSequence(CList,NList). List of the required colors in the sequence that are not being delivered by others yet.
%CList is a list of required colors and NList is the corresponding list of their places in the sequence.
remainingSequence([],[]).

%list of colors that have been delivered:
sequence([]).

%The next color that is required in the dropzone
nextColorInSequence([]).

%types of possible messages and their syntax
messageType(block, block(X,Y,Z)).
messageType(nblock, not(block(X,Y,Z))).
messageType(holding, holding(X,Y)).
messageType(nholding, not(holding(X,Y))).
messageType(in,in(X)).
messageType(nin, not(in(X))).
messageType(delivered,delivered(X)).
messageType(impholding, imp(holding(X,Y,Z,Q))).
messageType(nimpholding, imp( not( holding(X,Y,Z,Q)))).
messageType(impin, imp(in(NVal,RoomID))).
messageType(nimpin, imp(not(in(NVal,RoomID)))).
messageType(normal, normal).
