{application, lava_avoider,
 [ {description,  "lavaavoider, game about avoiding lava"}
 , {vsn,          "2.0.1"}
 , {id,           "lava_avoider"}
 , {modules,      [lava_avoider
                  , appsup
                  , playerSup
                  , mapSup
                  , timeSup
                  , gameSup
                  , playerServer
                  , timeServer
                  , mapServer
                  , gameServer]}
 , {registered, [playerSup, mapServer, timeServer, gameServer]}
 , {applications, [kernel, stdlib]}
 , {mod, {lava_avoider, []}}
 , {licenses, ["BSD-2-Clause"]}
 , {files, [ 
           ]}
 ]
}.
