:- module(fgoal_beliefs,
	  [
	   insert/1,
	   delete/1,
	   bel/1
	  ]).

:- dynamic hasBelief/1.

:- include('/var/lib/myfrdcsa/codebases/minor/free-life-planner/data-git/systems/planning/state-exporter').

insert(Bel) :-
  	assert(hasBelief(Bel)),
	with_output_to(atom(ABel),write_term(Bel,[quoted(true)])),
	atomic_list_concat([inserted,ABel,into,beliefbase],' ',Message),
	fgoal_log:log(Message).

delete(Bel) :-
  	retractall(hasBelief(Bel)),
	with_output_to(atom(ABel),write_term(Bel,[quoted(true)])),
	atomic_list_concat([deleted,ABel,from,beliefbase],' ',Message),
	fgoal_log:log(Message).

bel(Bel) :-
	pred_for_m(fgoal_beliefs,AllAssertedKnowledge),
	member(hasBelief(Bel),AllAssertedKnowledge).
