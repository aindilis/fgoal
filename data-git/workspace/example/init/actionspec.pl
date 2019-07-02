:- module(actionspec,[]).

goTo(Location) :-
	pre(zone(_,Location,_,_,_), state(S), S \= traveling),
	post(not(state(S)), state(traveling)).

goToBlock(BlockID) :-
	pre(block(BlockID,_,RoomID),at(RoomID), state(S), S \= traveling),
	post(not(state(S)), state(traveling)).

pickUp :-
	pre(atBlock(BlockID), not(holding(_,_)),not(state(traveling)), block(BlockID, ColorID, _),me(Me)),
	post(true).

putDown :-
	pre(me(Me), holding(Me, BlockID,ColorID), block(BlockID, ColorID, RoomID)),
	post(not(block(BlockID, ColorID, RoomID)), not(holding(Me, BlockID,ColorID))).
