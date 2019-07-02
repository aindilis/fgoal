:- use_module(dummyKnowledge,[]).

% The action printText expects a string of the form "..." as its argument. 
% It can always be performed and has no other effect than printing Text to a window.
printText(Text) :-
	pre(true),
	post(true).