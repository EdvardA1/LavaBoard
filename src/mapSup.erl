-module(mapSup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

%?Macro = macro returning the current module's name.q
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).
init([]) ->
	ChildSpecMapServer = {mapServer, 
				{mapServer, start_link, []},
		 		permanent, 
		 		500,
				worker,
				[mapServer]},
	SupFlag = {one_for_one,5,10},
	{ok,{SupFlag, [ChildSpecMapServer]}}.