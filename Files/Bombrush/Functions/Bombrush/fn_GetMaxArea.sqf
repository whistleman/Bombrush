private ["_name", "_centerpos", "_centerloc" ,"_max_x" ,"_max_y" ,"_maxdistance"];
_name      = worldName;
_centerpos = (configfile >> "CfgWorlds" >> _name >> "centerPosition");
_centerloc = getarray _centerpos;
_max_x     = (_centerloc select 0) * 1.75;
_maxdistance = _max_x;
_maxdistance