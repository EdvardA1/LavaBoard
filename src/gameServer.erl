-module(gameServer).
-behaviour(gen_server).
-export([start_link/0, print/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record(gamestate,{
        	map,                        % keys,value
        	players = maps:new(),		% players [{}]
        	time 						% Integer
         }).




start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


print() ->
	io:format("Hello world, Game Server\n").

init(_) ->
	print(),
	io:format("processiD Game: ~p\n", [self()]),
	Map = gen_server:call(mapServer, []),
	%TimePid = gen_server:call(timeServer, []),
	S = #gamestate{map = Map},
	{ok, S}.

handle_call({"Movement", Move}, {From, _}, Stat) ->
	io:format("handle_call ...~p and this is from~p and time is ~p\n", 
		[Stat#gamestate.players, From, Stat#gamestate.time]),

	[X, Y] = maps:get(From, Stat#gamestate.players),
	PlayerMap = maps:update(From, [X, Y+1], Stat#gamestate.players),
	NewState = Stat#gamestate{players = PlayerMap},
	{reply, NewState, NewState}.

handle_cast({"Time", Req}, Stat) ->
	if Stat#gamestate.time == undefined -> CurrentTime = 0;
		Stat#gamestate.time > 0 -> CurrentTime = Stat#gamestate.time
	end,
	NewTime = Req + CurrentTime,
	NewState = Stat#gamestate{time = NewTime},
	PlayersList = maps:keys(Stat#gamestate.players),
	loop_through_players(PlayersList, NewState),
	{noreply, NewState};
handle_cast({"Connected", Pid}, Stat) ->
	NewMap = maps:put(Pid, [0,0], Stat#gamestate.players),
	NewState = Stat#gamestate{players = NewMap},
	{noreply, NewState}.
handle_info(Info, Stat) ->
	{noreply, Stat}.

terminate(Supref, Id) ->

	io:format("The terminate function has been used at test").

code_change(_OldVsn, State, _Extra) ->
    %% No change planned. The function is there for the behaviour,
    %% but will not be used. Only a version on the next
    {ok, State}.


loop_through_players([], State) -> true;
loop_through_players([H|T], State) -> 
	gen_server:cast(H, State),
	loop_through_players(T, State).