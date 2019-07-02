:- module(program,[]).

(   bel(holding(BlockID,ColorID), block(BlockID, ColorID, RoomID)) ->
    (	bel(remainingSequence(TDL,_),not( memberchk(ColorID, TDL)),me(Me),in(Me,RoomID)) ->
	(   putDown + allother.send(:not(holding(BlockID,ColorID))) + bAnalyst.send(dropped)) ; fail) ; fail).

(   bel(at('DropZone'), not(state(traveling)), nextColorInSequence(ColorID),sequence(S),append(S,[ColorID],NewS)) ->
    (	putDown  + delete(sequence(S)) + insert(sequence(NewS)) + allother.send(delivered(ColorID)) + adopt(at('FrontDropZone')) ) ; fail).

(   (	a_goal(holding(Nval,Me,BlockID,ColorID,SeqID)), bel(me(Me),atBlock(BlockID),block(BlockID, ColorID,RoomID))) -> pickUp ; fail).

(   a_goal(atBlock(BlockID)) -> goToBlock(BlockID) ; fail).

(   a_goal(at(PlaceID)) -> (goTo(PlaceID) + bAnalyst.send(goto(PlaceID))) ; fail).			

(   (	bel(me(Me)), goal(in(_,Me,RoomID))) -> (goTo(RoomID) + bAnalyst.send(goTo(RoomID))) ; fail).
