:- module(helloWorld,[]).

use_module(dummyKnowledge,[]).

%% exit=always.

(   true -> write("Hello, world!") ; true).
