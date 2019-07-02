:- module(program,[]).

%% listall L <- goal(holding(_,_,BlockID,_,_)) do {
%% 						(   (	bel(remainingSequence([ColorID|_],[SeqID|_]), findOptiBlock(ColorID, L, Dist, OptiBlockID), me(Me),state(State), block(OptiBlockID, ColorID, RoomID), random(R), NVal is Dist + R)) -> adopt(at(RoomID),atBlock(OptiBlockID), holding(NVal, Me,OptiBlockID,ColorID,SeqID)) + allother.send(!holding(NVal, OptiBlockID,ColorID,SeqID)) + delete(state(State)) + insert(state(arrived)) ; fail)
%% 					       }

(   (	not(goal(holding(_,_,BlockID,_,_))),
	bel(remainingSequence([ColorID|_],[SeqID|_]), findOptiBlock(ColorID, [], Dist, OptiBlockID), me(Me),state(State), block(OptiBlockID, ColorID, RoomID), random(R), NVal is Dist + R)) ->
    (	
	adopt(at(RoomID),atBlock(OptiBlockID), holding(NVal, Me,OptiBlockID,ColorID,SeqID)) +
    allother.send(!holding(NVal, OptiBlockID,ColorID,SeqID)) +
    delete(state(State)) +
    insert(state(arrived))
    ) ; fail).
