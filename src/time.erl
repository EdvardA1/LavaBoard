-module(time).

-export([main/0]).
main() ->
	io:format("Exempel på timern").
%main(Time) ->
%	gen_server:cast("PID_ref"k Time),
%	timer:sleep(100),
%	main(Time+100).