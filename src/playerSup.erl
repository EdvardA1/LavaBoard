-module(playerSup).
-behaviour(supervisor).
-export([start_link/0]).
-export([init/1]).

%?Macro = macro returning the current module's name.
start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).
init([]) ->
	ChildSpecSimple = [ #{
						id => playerServer,
						start => {playerServer, start_link, []},
						shutdown => brutal_kill,
						type => worker,
						modules => [playerServer]}],
	%Supflag = {simple_one_for_one,5,10},
	SupFlags = #{strategy => simple_one_for_one,
                 intensity => 0,
                 period => 1},
	{ok,{SupFlags, ChildSpecSimple}}.