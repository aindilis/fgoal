:- module(fgoal_goals,
	  [
	   goal/1,
	   adopt/1,
	   drop/1
	  ]).

:- dynamic hasGoal/1, a_goal/1.

:- include('/var/lib/myfrdcsa/codebases/minor/free-life-planner/data-git/systems/planning/state-exporter').

goal(Goal) :-
	pred_for_m(fgoal_goals,AllAssertedKnowledge),
	member(a_goal(Goal),AllAssertedKnowledge).

adopt(Goal) :-
  	assert(a_goal(Goal)),
	with_output_to(atom(AGoal),write_term(Goal,[quoted(true)])),
	atomic_list_concat([adopted,AGoal,into,goalbase,main],' ',Message),
	fgoal_log:log(Message).

drop(Goal) :-
  	retractall(a_goal(Goal)),
	with_output_to(atom(AGoal),write_term(Goal,[quoted(true)])),
	atomic_list_concat([dropped,AGoal,from,goalbase,main],' ',Message),
	fgoal_log:log(Message).

