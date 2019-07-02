:- module(program,[]).

%% listall L <- goal(in(_,_,RoomID)) do {
%% 				      if bel(findOptiRoom(L,Dist,OptiRoom),me(Me), random(R), NVal is R+Dist) then adopt(in(NVal,Me,OptiRoom)) + allother.send(!in(NVal,OptiRoom)).
%% 				     }

(   (	not(goal(in(_,_,RoomID))), bel(findOptiRoom([],Dist,OptiRoom),me(Me), random(R), NVal is R+Dist)) ->
    adopt(in(NVal,Me,OptiRoom)) + allother.send(!in(NVal,OptiRoom)) ;
    fail).

(   (	not(goal(in(NVal,Me,OptiRoom))), bel(me(Me),not(at('FrontDropZone'))) ) -> adopt(at('FrontDropZone')) ; fail).
