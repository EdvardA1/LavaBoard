-module(timeServer).
-behaviour(gen_server).
-export([start_link/0, print/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


print() ->
	io:format("Hello World Time Server\n").

init(_) ->
	io:format("init test 2\n"),
	print(),
	io:format("processiD1: ~p\n", [self()]),
	Timer = timer:send_after(1000, self(), 1),
	{ok, Timer}.

handle_call(Req, _From, Stat) ->
	{reply, Req, undefined}.

handle_cast(Req, Stat) ->
	{noreply, Stat}.

handle_info(Info, Stat) ->
	timer:cancel(Stat),
	gen_server:cast(gameServer, {"Time", Info}),
	Timer = timer:send_after(1000, self(), 1),
	{noreply, Timer}.

terminate(Supref, Id) ->

	io:format("The terminate function has been used at test").

code_change(_OldVsn, State, _Extra) ->
    %% No change planned. The function is there for the behaviour,
    %% but will not be used. Only a version on the next
    {ok, State}.

timer_name(Time) ->
	io:format("Before cast"),
	gen_server:cast(gameServer,Time),
	io:format("After cast"),
	timer:sleep(100),
	timer_name(Time+10).