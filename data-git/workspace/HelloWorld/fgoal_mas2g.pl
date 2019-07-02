:- module(fgoal_mas2g,[launch/1,terminate/1]).

:- use_module(fgoal_log).

launch(_X) :-
	fgoal_log:log_time('start-up complete.'),
	fgoal_log:log_time('waiting for the first agent to be launched...'),
	fgoal_log:log_time('starting agent ''helloWorldAgent''.'),
	fgoal_log:log_time('started agent ''helloWorldAgent'' (took 26ms).').

terminate(_X) :-
	fgoal_log:log_time('agent ''helloWorldAgent'' terminated successfully.'),
	fgoal_log:log_time('all agents have stopped running.'),
	fgoal_log:log_time('shutting down the multi-agent system.'),
	fgoal_log:log_time('ran for 0 seconds.').