-module(test).
-behaviour(gen_server).
-export([start_link/0, print/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
start_link() -> gen_server:start_link(?MODULE, [], []).


print() ->
	io:format("Hello World\n").

init(_) ->
	io:format("init test 2\n"),
	print(),
	io:format("processiD1: ~p\n", [self()]),
	{ok, undefined}.

handle_call(Req, _From, Stat) ->
	io:format("handle_call ...~p\n", [Req]),
	{reply, "skriv ut nåt", undefined}.

handle_cast(Req, Stat) ->
	{noreply, Stat}.

handle_info(Info, Stat) ->
	{noreply, Stat}.

terminate(Supref, Id) ->

	io:format("The terminate function has been used at test").

code_change(_OldVsn, State, _Extra) ->
    %% No change planned. The function is there for the behaviour,
    %% but will not be used. Only a version on the next
    {ok, State}.