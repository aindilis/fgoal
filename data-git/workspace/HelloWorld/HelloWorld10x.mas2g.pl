:- module(helloWorldAgent,[]).

:- use_module(fgoal_mas2g).
:- use_module(initCounter).
:- use_module(helloWorld10x).
:- use_module(updateCounter).

:- launch(helloWorldAgent).

:- initCounter:init.

:- forall(between(1,11,N),
	  (   
	      fgoal_log:log('non-state actions: 0, send actions 0, state queries: 0, total[beliefs: 1, goals: 0, messages: 0, percepts: 0]'),
	      atomic_list_concat(['+++++++ Cycle ',N,' +++++++'],'',CycleLine),
	      writeln(CycleLine),
	      helloWorld10x:init,
	      updateCounter:init
	  )).

:- terminate(helloWorldAgent).


%% main :- initCounter:init.

%% main :- repeat,
%% 	fgoal_log:log('non-state actions: 0, send actions 0, state queries: 0, total[beliefs: 1, goals: 0, messages: 0, percepts: 0]'),
%% 	atomic_list_concat(['+++++++ Cycle ',N,' +++++++'],'',CycleLine),
%% 	writeln(CycleLine),
%% 	helloWorld10x:init,
%% 	updateCounter:init.

%% main :- terminate(helloWorldAgent).