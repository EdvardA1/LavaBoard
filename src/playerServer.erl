-module(playerServer).
-behaviour(gen_server).

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

start_link() -> gen_server:start_link(?MODULE, [], []).


init(_) ->
	gen_server:cast(gameServer, {"Connected", self()}),
	io:format("PlayerID: ~p\n", [self()]),
	{ok, undefined}.

handle_call("Up", _From, Stat) ->
	io:format("handle_call ... player\n"),
	gen_server:call(gameServer, {"Movement", "Up"}),
	{reply, "Handle Call from playerServer after gameServer", undefined}.

handle_cast(S, Stat) ->
	%io:format("handle_cast time is:~p for player:~p\n", [S, self()]),
	{noreply, Stat}.

handle_info(Info, Stat) ->
	{noreply, Stat}.

terminate(Supref, Id) ->

	io:format("The terminate function has been used at test").

code_change(_OldVsn, State, _Extra) ->
    %% No change planned. The function is there for the behaviour,
    %% but will not be used. Only a version on the next
    {ok, State}.