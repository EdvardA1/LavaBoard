-module(mapServer).
-behaviour(gen_server).
-export([start_link/0, print/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).


start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


print() ->
	io:format("Hello World Map server\n").

init(_) ->
	Map = create_map(),
	io:format("\n Map created: ~p\n", [self()]),
	print(),
	{ok, Map}.

handle_call(Req, _From, Stat) ->
	io:format("handle_call in Maps\n"),
	{reply, Stat, Stat}.

handle_cast(Req, Stat) ->
	io:format("handle_cast in Maps\n"),
	{noreply, Stat}.

handle_info(Info, Stat) ->
	io:format("handle_info in Maps\n"),
	{noreply, Stat}.

terminate(Supref, Id) ->

	io:format("The terminate function has been used at test").

code_change(_OldVsn, State, _Extra) ->
    %% No change planned. The function is there for the behaviour,
    %% but will not be used. Only a version on the next
    {ok, State}.

create_map() ->
    {ok,Input} = file:read_file("test_map.txt"),
    Input_str = binary_to_list(Input),
    Input_list = string:split(Input_str, "\n", all),
    Tuple = lists:map(fun map_func/1, Input_list),
    maps:from_list(Tuple).

map_func(String) ->
    [Key, Value] = string:split(String, " ", all),
    [X, Y] = string:split(Key, ","),
    {{list_to_integer(X), list_to_integer(Y)}, list_to_integer(Value)}.