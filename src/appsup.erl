-module(appsup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

%?Macro = macro returning the current module's name.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).
init([]) ->

	ChildSpecPlayer = {playerSupervisor, 
				{playerSup, start_link, []},
		 		permanent, 
		 		500,
				supervisor,
				[playerSup]},
	ChildSpecMap = {mapSupvisor, 
				{mapSup, start_link, []},
		 		permanent, 
		 		500,
				supervisor,
				[mapSup]},
	ChildSpecTime = {timeSupvisor, 
				{timeSup, start_link, []},
		 		permanent, 
		 		500,
				supervisor,
				[timeSup]},
	ChildSpecGame = {gameSupvisor, 
				{gameSup, start_link, []},
		 		permanent, 
		 		500,
				supervisor,
				[gameSup]},
	SupFlag = {one_for_one,5,10},
	{ok,{SupFlag, [ChildSpecPlayer,ChildSpecMap, ChildSpecTime, ChildSpecGame]}}.