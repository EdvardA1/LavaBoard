-module(lava_avoider).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
	io:format("Start of lava_avoider"),
	appsup:start_link().

stop(_State) ->
	ok.


