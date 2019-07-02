:-dynamic order/2, in/2, loc/2, home/1.

ordered(C,P) :- order(C,Y), member(P,Y).
loaded_order(C) :- order(C,O), loaded(O).
loaded([P]) :- in(P, truck).
loaded([P|L]) :- in(P,truck), loaded(L).
empty :- not(in(P,truck)).
%packed :- in(P, truck), in(P1, truck), not(P=P1).
packed :- setof(P,in(P,truck),L), length(L,X), X>=2.
%delivered_order(C) :- order(C,O),loc(C,X),orderloc(O,X),loc(truck,a).
delivered_order(C) :- order(C,O),loc(C,X),orderloc(O,X).
orderloc([H|T], X) :- loc(H,X), orderloc(T,X).     
orderloc([], X). 
