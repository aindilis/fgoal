:- module(fgoal_log,[log/1,log_time/1]).

:- use_module(fgoal_util_dates).

log(X) :-
	getCurrentDateTime([_,H:M:S]),
	atom_number(AH,H),
	atom_number(AM,M),
	atom_number(AS,S),
	atomic_list_concat([AH,AM,AS],':',TimeStamp),
	atomic_list_concat([TimeStamp,',[helloWorldAgent] ',X,' helloWorldAgent.,'],'',CX),
	writeln(CX).

log_time(X) :-
	getCurrentDateTime([_,H:M:S]),
	atom_number(AH,H),
	atom_number(AM,M),
	atom_number(AS,S),
	atomic_list_concat([AH,AM,AS],':',TimeStamp),
	atomic_list_concat([TimeStamp,X],',',CX),
	writeln(CX).
