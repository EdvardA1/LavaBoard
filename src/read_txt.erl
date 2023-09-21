-module(read_txt).

-export([main/0]).

main() ->
    {ok,Input} = file:read_file("test_map.txt"),
    Input_str = binary_to_list(Input),
    Input_list = string:split(Input_str, "\n", all),
    Tuple = lists:map(fun map_func/1, Input_list),
    M1 = maps:from_list(Tuple),
    io:format("~p\n", [M1]).

map_func(String) ->
    Two_elem = string:split(String, " ", all),
    {lists:nth(1,Two_elem),lists:nth(2,Two_elem)}.