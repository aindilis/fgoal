:- module(knowledge,[]).

room(PlaceID) :- zone(_,PlaceID,_,_,Neighbours), length(Neighbours,1).

holding(BlockID,ColorID) :- me(Me), holding(Me, BlockID,ColorID).

holding(_,Agent, BlockID,ColorID,_) :- holding(Agent, BlockID,ColorID).

in(_,Agent,RoomID) :- in(Agent,RoomID).	

atBlock(BlockID) :- holding(BlockID,_).

findOptiRoom(RL,Dist,OptiRoom) :-
	at(MyLoc),
	findall((D,RoomID),(room(RoomID),not(visited(RoomID)),not(memberchk(RoomID,RL)),RoomID\='DropZone',findPath([MyLoc],RoomID,D)), L),
	sort(L,RoomList), [(Dist,OptiRoom)|_] = RoomList.

findOptiBlock(ColorID, BL, Dist, OptiBlock) :-
	findall((D,SomeBlockID), (block(SomeBlockID,ColorID, SomeRoomID),not(memberchk(SomeBlockID, BL)), deliveryDistance(SomeRoomID,D)),L),
	sort(L,BlockList), [(Dist,OptiBlockID)|_] = BlockList.

deliveryDistance(RoomID,Dist) :- at(MyLoc), findPath([MyLoc],RoomID,Dist1),findPath([RoomID],'FrontDropZone',Dist2),Dist is Dist1+Dist2.

findPath(Start,Finish, 0) :- memberchk(Finish,Start),!.

findPath(Start,Finish, Distance) :-
	extendsearch(Start,[],NeighbourList),
	sort(NeighbourList,SortedNeighbourList),
	findPath(SortedNeighbourList, Finish, D),
	Distance is D+1.

extendsearch([Room|Roomlist],OldNeigbourList,CompleteNeighbourList) :-
	zone(_,Room,_,_,Neigbours),
	append(Neigbours,OldNeigbourList,NewNeighbourList),
	extendsearch(Roomlist,NewNeighbourList,CompleteNeighbourList).
extendsearch([],CompleteNeighbourList,CompleteNeighbourList).

reducelistn(CList,NList,[],CList,NList).
reducelistn(CList,NList,[[_,SeqID]|T],NewCList,NewNList) :-
	nth0(Indx,NList,SeqID,UNList),
	nth0(Indx,CList,_,UCList),
	reducelistn(UCList,UNList,T,NewCList,NewNList).

reducelistc(CList,NList,[],CList,NList).
reducelistc(CList,NList,[[_,ColorID]|T],NewCList,NewNList) :-
	nth0(Indx,CList,ColorID,UCList),
	!,
	nth0(Indx,NList,_,UNList),
	reducelistc(UCList,UNList,T,NewCList,NewNList).
