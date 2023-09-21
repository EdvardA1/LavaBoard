-record(gamestate,{
        	map,                        % keys,value
        	players = maps:new(),		% players [{}]
        	time 						% Integer
         }).