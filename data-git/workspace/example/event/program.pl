:- module(program,[]).
				
forall(bel(percept(state(NewState)),state(State)),delete(state(State)) + insert(state(NewState))). 		

forall(bel(percept(in(RoomID)),me(Me)),insert(in(Me,RoomID)) + allother.send(:in(RoomID))).
forall(bel(percept(not(in(RoomID))),me(Me))delete(in(Me,RoomID)) + allother.send(:not(in(RoomID)))).

forall(bel(at(Placeid), percept(at(NewPlaceid))),delete(at(Placeid)) + insert(at(NewPlaceid))).

forall(bel(percept(atBlock(BlockID))),insert(atBlock(BlockID))).
forall(bel(percept(not(atBlock(BlockID)))),delete(atBlock(BlockID))).

forall(bel(percept(color(BlockID, ColorID)), not(block(BlockID, ColorID,_)),me(Me),in(Me,RoomID)),
       insert(block(BlockID, ColorID,RoomID)) + allother.send(:block(BlockID, ColorID,RoomID))).

forall(bel(percept(holding(BlockID)), me(Me),block(BlockID,ColorID,RoomID), not(holding(Me, BlockID,ColorID))),
       insert(holding(Me, BlockID,ColorID)) + allother.send(:holding(BlockID,ColorID)) + allother.send(not(block(BlockID, ColorID, RoomID)))).
forall(bel(percept(not(holding(BlockID))), me(Me),holding(Me,BlockID, ColorID)),
       delete(holding(Me, BlockID,ColorID)) + allother.send(:not(holding(BlockID,ColorID)))).

forall(bel(percept(occupied(RoomID))),insert(occupied(RoomID))).
forall(bel(percept(not(occupied(RoomID)))),delete(occupied(RoomID))).

forall(bel(percept(sequenceIndex(NewInteger))),bAnalyst.send(sequenceIndex(NewInteger))).

forall(bel(in(Me,RoomID), block(BlockID,ColorID,RoomID),not(percept(color(BlockID, ColorID))),not(holding(BlockID,ColorID)),me(Me)),
       delete(block(BlockID,ColorID,RoomID)) + allother.send(not(block(BlockID,ColorID,RoomID)))).

forall(bel(in(Me,RoomID), not(visited(RoomID)),me(Me)),
       insert(visited(RoomID))).

forall(bel(received(Sender, successRate(Type, SRate)), me(Me)),insert(successRate(Type, SRate))).

forall(bel(successRate(Type, SRate), messageType(Type,Message), received(Sender, Message), random(R)),
       (   (   bel(R>=SRate) -> delete(received(Sender, Message)) + bAnalyst.send(failed(Type)) ; true),
	   (   bel(R<SRate) -> bAnalyst.send(success(Type)); true))).
													 } 

forall(bel(received(Sender, block(BlockID, ColorID,RoomID)), not(block(BlockID,ColorID,RoomID))),insert(block(BlockID, ColorID,RoomID))).
forall(bel(received(Sender, not(block(BlockID, ColorID,RoomID))), block(BlockID,ColorID,RoomID), not(holding(BlockID,ColorID))),delete(block(BlockID, ColorID,RoomID))).		

forall(bel(received(Sender, holding(BlockID,ColorID)), not(holding(Sender,BlockID,ColorID))),insert(holding(Sender,BlockID,ColorID))).
forall(bel(received(Sender, not(holding(BlockID,ColorID))), holding(Sender,BlockID,ColorID)),delete(holding(Sender,BlockID,ColorID))).

forall(bel(received(Sender, in(RoomID)), not(in(Sender,RoomID))),
       (   (   true -> insert(in(Sender,RoomID)) ; true),
	   (   bel(not(visited(RoomID))) ->  insert(visited(RoomID)) ; true))).
								    }		
forall(bel(received(Sender, not(in(RoomID))), in(Sender,RoomID)), delete(in(Sender,RoomID))).

forall(bel(received(Sender, delivered(ColorID))),
       (   (   bel(sequence(S),append(S,[ColorID],NewS)) -> delete(sequence(S)) + insert(sequence(NewS)) ; true),
	   (   bel(holding(Sender,BlockID,ColorID)) -> delete(holding(Sender,BlockID,ColorID)) ; true))).

forall(bel(received(Sender, imp(holding(NVal,BlockID,ColorID,SeqID)))),adopt(holding(NVal,Sender,BlockID,ColorID,SeqID))).		
forall(bel(received(Sender, imp( not( holding(NVal,BlockID,ColorID,SeqID)))),me(Me)),drop(holding(NVal,Sender,BlockID,ColorID,SeqID))).

forall(bel(received(Sender, imp(in(NVal,RoomID)))), adopt(in(NVal,Sender,RoomID))).
forall((bel(received(Sender, imp( not (in(NVal,RoomID))))), goal(in(NVal,Sender,RoomID))),
       drop(in(NVal,Sender,RoomID))).						

forall(bel(received(Sender, Message)),delete(received(Sender, Message))).

forall((bel(me(Me), state(State)), goal(holding(NVal,Me, BlockID,ColorID,SeqID))),
       (   
	   forall((goal(holding(PVal,Other,SomeBlockID,ColorID,SeqID)), bel(Other \= Me, NVal>PVal)),
		  drop(holding(NVal, Me,BlockID,ColorID,SeqID)) + allother.send(!not(holding(NVal,BlockID,ColorID,SeqID))) +
		 delete(state(State)) + insert(state(arrived))),
	   forall(bel(not(block(BlockID,_,_))),
		  drop(holding(NVal, Me,BlockID,ColorID,SeqID)) + allother.send(!not(holding(NVal,BlockID,ColorID,SeqID))) +
		 delete(state(State)) + insert(state(arrived)))
       )).

										   
forall((bel(me(Me),state(State)), goal(in(NVal,Me,RoomID))),
       forall((goal(in(PVal,Other,RoomID)), bel(Other \= Me, NVal>PVal)),
	      drop(in(NVal,Me,RoomID)) + allother.send(!not(in(NVal,RoomID))) + delete(state(State)) + insert(state(arrived)))).
							     }
(   (	goal(sequence(S)), bel(sequence(DoneList),remainingSequence(C,N), append(DoneList,Clist,S), Clist \= C, 
			       length(S,Last),length(Clist,Nlength), Start is Last-Nlength, End is Last-1, numlist(Start, End, Nlist))) ->
 delete(remainingSequence(C,N)) + insert(remainingSequence(Clist,Nlist)) ; true).

(   bel(remainingSequence([NextC|_],_), nextColorInSequence(C), C\=NextC) -> delete(nextColorInSequence(C)) + insert(nextColorInSequence(NextC)); fail).

%Remove elements that are currently a goal to be delivered from remainingSequence except for my own work (ugly implementation because listall).
if bel(me(Me)), goal(holding(_,Me,_,_,MySeqID)) then {
						      listall L <- goal(holding(_,Agent,_,_,SeqID)), bel(Agent \= Me, SeqID \= MySeqID) do {
																	    if bel(remainingSequence(CList,NList), reducelistn(CList,NList,L,NewCList,NewNList)) then delete(remainingSequence(CList,NList)) + insert(remainingSequence(NewCList,NewNList)).
																	   }
						     }		
if bel(me(Me)), not(goal(holding(_,Me,_,_,_))) then {
						     listall L <- goal(holding(_,Agent,_,_,SeqID)) do {
												       if bel(remainingSequence(CList,NList), reducelistn(CList,NList,L,NewCList,NewNList)) then delete(remainingSequence(CList,NList)) + insert(remainingSequence(NewCList,NewNList)).
												      }
						    }	

%Remove elements that are currently held by an agent from remainingSequence.
listall L <- bel(holding(Agent,_,ColorID),not(me(Agent))) do {
							      if bel(remainingSequence(CList,NList), reducelistc(CList,NList,L,NewCList,NewNList)) then delete(remainingSequence(CList,NList)) + insert(remainingSequence(NewCList,NewNList)).
							     }

%		//////////////////////////////////////////
%		set/update goals
%		\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

forall bel(me(Me), state(State)), goal(holding(NVal,Me, BlockID,ColorID,SeqID)) do {
%drop block when color is no longer needed (should not happen under normal circumstances)
										    if bel(remainingSequence(TDL,_),not( memberchk(ColorID, TDL))) then drop(holding(NVal, Me,BlockID,ColorID,SeqID)) + allother.send(!not(holding(NVal,BlockID,ColorID,SeqID))) + delete(state(State)) + insert(state(arrived)). % + print([Me,'dropped goal',ColorID]).% +   log(bb)+log(mb)+log(gb)+log(pb).
										   }

% don't go to or be in dropzone if you don't hold the next required block
forall bel(holding(Me, BlockID,ColorID),  not(nextColorInSequence(ColorID)), state(State), me(Me)) do {
												       forall goal(at('DropZone')) do drop(at('DropZone')) + adopt(at('FrontDropZone'))+ delete(state(State)) + insert(state(arrived)).
												      forall bel(at('DropZone')) do adopt(at('FrontDropZone'))+ delete(state(State)) + insert(state(arrived)).
												      }

%If not delivering a block or exploring a room then select a block to deliver
if bel(me(Me),not(holding(_,_))), not(goal(holding(_,Me,_,_,_);at(_);in(_,Me,_))) then nextBlockSelection.

%when holding a block then go to the dropzone, via frontdropzone
if bel(holding(BlockID,ColorID), block(BlockID, ColorID, RoomID),me(Me)) then {
%always go to frontdropzone with a block
									       if not(goal(at('FrontDropZone'))), bel(at(PlaceID), PlaceID \= 'FrontDropZone', PlaceID \= 'DropZone') then adopt(at('FrontDropZone')).
%go to dropzone if holding the next required color
									      if bel(at('FrontDropZone'),nextColorInSequence(ColorID), not(occupied('DropZone'))) then adopt(at('DropZone')).	
									      }	

%if not holding a block, or going to a block/place then select a room to explore
if bel(me(Me),not(holding(_,_))), not(goal(at(_); atBlock(_); in(_,Me,_))) then nextRoomSelection.


%		/////////////////////////////////////////////////
%		End of Life management
%  		\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%not part of functional program, but required to get statistics and do quick batchruns.	

forall not(goal(sequence(S))) do {
%send signal to the analyist that the agent is finished.	
				  if true then bAnalyst.send(finished) + insert(sentLogs).

%stop going to places
				 forall goal(at(SomePlace)) do drop(at(SomePlace)).
				 forall goal(in(NVal,Me,SomePlace)) do drop(in(NVal,Me,SomePlace)).
				 forall goal(holding(NVal,Agent,BlockID,ColorID,SeqID)) do drop(holding(NVal,Agent,BlockID,ColorID,SeqID)).
				 }
