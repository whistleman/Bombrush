	//SYNTAX [ position, minimum distance, maximum distance, maximum distance from nearest object, 0 = cant be in water, terrain gradient, 0 = shore mode]

	_playerpos	   	= _this select 0;
	diag_log format ["Playerpos is %1", _playerpos];
	//_mindist   	= _this select 1;
	//_maxdist	   	= _this select 2;
	_maxdistobj		= _this select 3;
	_inwater		= _this select 4;
	_terraingrad	= _this select 5;
	_shoremode		= _this select 6;

	_name      = worldName;
	_centerpos = (configfile >> "CfgWorlds" >> _name >> "centerPosition");
	_centerloc = getarray _centerpos;
	_max_x     = (_centerloc select 0) * 1.75;
		diag_log format ["Max X is %1", _max_x];

	_maxdistance 	= call BR_fnc_GetMaxArea;
		diag_log format ["Max distance is %1", _maxdistance];
	_mindistance 	= _maxdistance / 4;

	_newpos = [_playerpos, _mindistance, _maxdistance, 2, 0, 20, 0] call BIS_fnc_Findsafepos;
		diag_log format ["First newpos is %1", _newpos];
	if (((_newpos select 0) > _max_x) || ((_newpos select 1) > _max_x) || ((_newpos select 0) < 0) || ((_newpos select 1) < 0)) then {
		WIS_INIT_Correct_Pos = false;
		diag_log format ["Did not find safe pos at %1", _newpos];
		while {!WIS_INIT_Correct_Pos} do {
			_newpos = [_playerpos, _mindistance, _maxdistance, 2, 0, 20, 0] call BIS_fnc_Findsafepos;
			if (((_newpos select 0) > _max_x) || ((_newpos select 1) > _max_x)) then {
				diag_log format ["Did not find safe pos at %1", _newpos];
				WIS_INIT_Correct_Pos = false;
				} else {
				WIS_INIT_Correct_Pos = true;
				diag_log format ["The newpos is %1", _newpos];
				_newpos
				};
			};
		} else {
		WIS_INIT_Correct_Pos = true;
		diag_log format ["The newpos is %1", _newpos];
		_newpos
	};