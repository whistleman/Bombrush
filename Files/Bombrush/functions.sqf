//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
// functions.sqf
// Credits to Spliffz, FAROOQ, EGG_EVO, T-800a, Tajin, Kronzky, Zorilya, D4nny, Spectre
//
//////////////////////////////////////////////////////////////////////////////////////////////

diag_log "functions is loaded";

spliffz_fnc_makeArrayFromGroup = {
		_grp = _this select 0;
		_array = [];
		{
				_array set [(count _array), _x];
		} foreach units _grp;

		_array
};

fnc_Whistle_create_units = {
//SYNTAX ["Marker where to spawn(String)", "Amount of units spawned", "Random amount extra spawned", ["Array of units that the script chooses from"], "marker to patrol (string)"] call fnc_Whistle_create_units;
_grp			= CreateGroup EAST;
_n 				= (_this select 1) + random (_this select 2);
_unitarray 		= _this select 3;

for "_x" from 1 to _n do {
        _unitInGroup = (_unitarray select (floor (random ((count _unitarray) - 1)))) createUnit [getmarkerpos (_this select 0), _grp];
};

{[_x, Whistle_skill] call EGG_EVO_skill;} foreach units _grp;
[_grp] call spliffz_terror_gear_unit;

_nobj = nearestObjects [(getmarkerpos (_this select 0)), ["House"], 20];
if ((count _nobj) > 3) then {
	_nul = [_grp, 50, false,	[60,1], false, true] execVM "files\AI\Garrison_script.sqf";
	} else {
		if (!isNil "Whistle_Money_amount") then {
			if (Whistle_Money_amount < ((ParamsArray select 10) / (random(2)))) then {
				if ((random (10)) > 2) then {
					_posveh = [(getmarkerpos "Bomb"), 5, 35, 3, 0, 20, 0] call BIS_fnc_findSafePos;
					_veh = "B_G_Offroad_01_armed_F" createvehicle _posveh;
					_grp addVehicle _veh;
					_wp = _grp addWaypoint [position _veh, 0];
					_wp setWaypointType "GETIN";
				};
			};
		};
	[([_grp] call spliffz_fnc_makeArrayFromGroup), _this select 4,"random"] execVM "files\AI\UPS.sqf";
	};
if ((daytime > 19.15) && (5 < daytime)) then {_grp enableGunLights "forceOn";};
};

fnc_Whistle_Bombs_amount = {Whistle_Bombs_amount = Whistle_Bombs_amount - 1;};

fnc_Whistle_explode = {
_shellarray = ["M_Mo_82mm_AT_LG", "Bo_GBU12_LGB", "HelicopterExploBig", "Bo_Mk82", "Bo_GBU12_LGB_MI10", "Bo_Mk82_MI08"];
_shell 	   = _shellarray select (floor(random (5)));
_explosion = _shell createvehicle position (_this select 0);
{removeallactions _x} foreach playableunits;
[] call fnc_Whistle_detonatedbombsallowed;
};

fnc_Whistle_delete_all = {
	IF (ISSERVER) THEN {
	_theobj 	= _this select 0;
	_explode 	= _this select 1;
	_sleepertt  = _this select 2;
	_defuse		= _this select 3;
	if (_explode == 1) then {
		[Whistle_Bomb] call fnc_Whistle_explode; 
		WIS_task_fetch_fail = WIS_task_fetch_fail + 1;
		publicvariable "WIS_task_fetch_fail";
	};
	if (_defuse == 1) then {
		Whistle_Money_amount = Whistle_Money_amount + 2; 	
		WIS_task_fetch	= WIS_task_fetch + 1;
		publicvariable "WIS_task_fetch";
	};
	publicvariable "Whistle_Money_Amount";
	Whistle_INIT_TIMER = false;
	"Oldpos" setMarkerPos getpos Whistle_Bomb;
	deletevehicle Whistle_Bomb;
	deletemarker "bombpatrol";
	deletemarker "Bomb";
	deletemarker "Areamarker";
	deletemarker "Bombmrk";
	deletemarker "Centerpos";
	sleep 1;
	END_TIME = 0;
	if (_sleepertt > 0) then {sleep _sleepertt;};
	[] spawn fnc_make_new_bomb;
	[] spawn WIS_fnc_enemy_replacement;
	} else {
	sleep 5;
	[0,player] call fnc_check_bankaccount;
	};
};

fnc_Whistle_delete_all_MP = {
	IF (ISSERVER) THEN {
	[Whistle_Bomb] call fnc_Whistle_explode;
	Whistle_INIT_TIMER = false;
	"Oldpos" setMarkerPos getpos Whistle_Bomb;
	deletevehicle Whistle_Bomb;
	deletemarker "bombpatrol";
	deletemarker "Bomb";
	deletemarker "Areamarker";
	deletemarker "Bombmrk";
	deletemarker "Centerpos";	
	sleep 1;
	END_TIME = 0;
	WIS_task_fetch	= WIS_task_fetch + 1;
	publicvariable "WIS_task_fetch";
	[] spawn fnc_make_new_bomb;
	};
};

Spliffz_fnc_buildingpos = {
_building = _this select 0;
_cbpos = 0;
    for "_x" from 1 to 100 do {

        //_bpos = _building buildingPos _x;

        if (format ["%1",(_building buildingPos _x)] != "[0,0,0]") then {
            _cbpos = _cbpos + 1;
        };

    };
    _bpos = round (random _cbpos);
	_bpos
};



/*
Tajin_fnc_buildingpos = {
private ["_unit", "_building", "_odist", "_i", "_sel" ,"_dist"];
_unit = _this select 0;
_building = nearestBuilding _unit;

_odist = 99999;
_i = 0;
_sel = 0;

while { (_building buildingPos _i) distance [0,0,0] > 0 } do {
    _dist = (_building buildingPos _i) distance _unit;
    if (_dist < _odist) then {
        _sel = _i;
        _odist = _dist;
    };
    _i = _i + 1;
};

_unit setPos (_building buildingPos _sel);
//_unit setUnitPos "UP";
};
*/

fnc_Whistle_detonatedbombsallowed = {Whistle_detonatedbombsallowed = Whistle_detonatedbombsallowed - 1;
if (Whistle_detonatedbombsallowed  == 0) then {"LOSER" call BIS_fnc_endMission;};};

fnc_make_new_bomb = {
	if (Whistle_Bombs_amount == 0) then {"LOSER" call BIS_fnc_endMission;};
	if ((not alive Whistle_bomb) && (Whistle_Bombs_amount > 0) && (isNull Whistle_bomb)) then {[] execVM "Files\Bombrush\bomb.sqf";};
};

EGG_EVO_skill = {
	_unit 	= _this select 0;
	_skill 	= _this select 1;

	if(_skill < 5) then {
        _aiSkillBase = 1.0;

        switch (_skill) do
        {
            case 0: //conscript very low skill
            {
                _aiSkillBase = 0;
            };
            case 1: //rebels low skill
            {
                _aiSkillBase = 0.25;
            };
            case 2: //regular fair skill
            {
                _aiSkillBase = 0.5;
            };
            case 3: //elite soldiers medium skill
            {
                _aiSkillBase = 0.75;
            };
            case 4: // specops good skill
            {
                _aiSkillBase = 1;
            };
        };

        _unit setskill _aiSkillBase;
        _unit setskill ["general", _aiSkillBase];
        _unit setskill ["aimingAccuracy", (_aiSkillBase * 0.25)];
        _unit setskill ["aimingShake", (_aiSkillBase * 0.30)];
        _unit setskill ["aimingSpeed", (_aiSkillBase * 0.40)];
        _unit setskill ["endurance", _aiSkillBase];
        _unit setskill ["spotDistance", (_aiSkillBase * 0.25)];
        _unit setskill ["spotTime", (_aiSkillBase * 0.50)];
        _unit setskill ["courage", _aiSkillBase];
        _unit setskill ["reloadSpeed", (_aiSkillBase * 0.80)];
        _unit setskill ["commanding", (_aiSkillBase * 0.75)];
	};
};

T8_fnc_addActionBomb =
{
	//_this addeventhandler ["HitPart", {["[_this]", "fnc_Whistle_delete_all_MP", true, true] spawn BIS_fnc_MP;}];
	_this addeventhandler ["HitPart", {[[_this select 0, 1, 30, 0], "fnc_Whistle_delete_all", true, true] spawn BIS_fnc_MP;}];
	_this addAction ["Defuse bomb", "Files\Bombrush\Defuse.sqf"];
};

// WIP ///////////////////////////////

T8_fnc_addActionTelephoneBank = {
	_this addAction ["Pay terorrists $ 100.000", "Files\Bombrush\Whistle_Handleactions.sqf", ["fnc_Pay_Money"]];
};

T8_fnc_addActionTelephoneNikos = {
	_this addAction ["Call Nikos", "Files\Bombrush\Whistle_Handleactions.sqf", ["fnc_call_Nikos"]];
};

T8_fnc_addActionTelephoneBalance = {
	_this addAction ["Check you balance", "Files\Bombrush\Whistle_Handleactions.sqf", ["fnc_check_bankaccount"]];
};

fnc_Money_Paid = {
	if (isServer) then {
		if (alive Whistle_bomb) then {
			if (Whistle_Money_amount >= 10) then {
					Whistle_Money_amount = Whistle_Money_amount - 10;
					Whistle_terrorist_money_amount = Whistle_terrorist_money_amount + 10;
					publicvariable "Whistle_Money_amount";
					[Whistle_bomb, 0, 500, 0] spawn fnc_Whistle_delete_all;
					[[1], "fnc_Money_Paid_Hint", true, true] spawn BIS_fnc_MP;
				};
			} else {
		[[0], "fnc_Money_Paid_Hint", true, true] spawn BIS_fnc_MP;
		};
	};
};

fnc_Pay_Money = {
	["[]", "fnc_Money_Paid", true, true] spawn BIS_fnc_MP;
};

fnc_check_bankaccount = {
	_caller = _this select 1;
	_caller globalchat format ["We have %1 left", Whistle_Money_amount * 10000];
};

fnc_call_Nikos = {
	_telephone = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	["[]","fnc_playsoundNikos", WEST, false] spawn BIS_fnc_MP;
	["[]", "fnc_intel_Nikos", true, true] spawn BIS_fnc_MP;
};

fnc_intel_Nikos = {

if (isServer) then {
	//if (getMarkerColor "Intel" == "") then {} else {deletemarker "Intel"; deletemarker "intelpatrol"; };
	if (Whistle_Money_amount >= 5) then {
		Whistle_Money_amount = Whistle_Money_amount - 5;
		publicvariable "Whistle_Money_amount";
		Whistle_Nikos_money_amount = Whistle_Nikos_money_amount +5;
			_randomizer = (random (10));
			if (_randomizer > (Whistle_Nikos_money_amount / 5)) then {
				_maxdistance 	= call Wis_fnc_Get_Max_Area;
				_newPos 		= [(getmarkerpos "Respawn_west"), 3000, 30000, 1, 0, 50, 0] call WIS_fnc_Check_Inside_Area;
				
				_intelmrk = createmarker ["Intel", _newpos];
				_intelmrk setMarkerType "hd_objective";
				_intelmrk setmarkercolor "ColorRed";
				_now 	= date;
				_day 	= _now select 2;
				_month 	= _now select 1;
				_year 	= _now select 0;
				_hour 	= _now select 3;
				_minute = _now select 4;
				_intelmrk setMarkerText format ["Intel Nikos %1-%2-%3 time: %4:%5", _day, _month, _year, _hour, _minute];
				"Intel" setMarkeralpha 1;

				_intelpatrolmrk = createmarker ["intelpatrol", _newpos];
				_intelpatrolmrk setMarkerShape "ELLIPSE";
				_intelpatrolmrk setMarkerSize [150, 150];
				"intelpatrol" setMarkeralpha 0;
				_n = 3;

				for "_x" from 1 to _n do {
				["intel" , 4, _n, ["O_Soldier_F", "O_medic_F", "O_Soldier_SL_F", "O_Soldier_AA_F", "O_soldier_exp_F"], "intelpatrol"] call fnc_Whistle_create_units;
				};

			} else {
				"camp" setMarkeralpha 1;
			};
		};
	} else {
	player globalchat format ["We have %1 left", Whistle_Money_amount * 10000]};
};


fnc_playsound = {
	playsound "Plantedbomb"; sleep 3.5;
	cutText ["A Mysterious voice says: We have planted a bomb","PLAIN",2];
};

fnc_playsoundNikos = {
	playsound "Nikos"; sleep 6;
	cutText ["Nikos here, I have placed a marker on your map","PLAIN",2];
};

fnc_Money_Paid_Hint = {
	_playmeahint = _this select 0;
	if (_playmeahint == 1) then {
	cutText ["You have paid the terrorists the money","PLAIN",2];
	} else {
	cutText ["Why would you pay the money when there is no bomb?","PLAIN",2];
	};
};

Wis_fnc_Get_Max_Area = {
	private ["_name", "_centerpos", "_centerloc" ,"_max_x" ,"_max_y" ,"_maxdistance"];
	_name      = worldName;
	_centerpos = (configfile >> "CfgWorlds" >> _name >> "centerPosition");
	_centerloc = getarray _centerpos;
	_max_x     = (_centerloc select 0) * 1.75;
	_maxdistance = _max_x;
	_maxdistance
};

WIS_fnc_Check_Inside_Area = {
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

	_maxdistance 	= call Wis_fnc_Get_Max_Area;
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
};

WIS_fnc_end_mission = {"END1" call BIS_fnc_endMission;};

WIS_fnc_taskstate = {
	_task = _this select 0;
	_state = _this select 1;
	_task settaskstate _state;
	diag_log format ["Whistle *-* Task is %1, State should be %2", _task, _state];
	if (_state == "Succeeded") then {
		["TaskSucceeded",["", format ["%1 %2", _task, _state]]] call BIS_fnc_showNotification;
		//taskhint [format ["%1 %2", _task, _state], [1, 0, 0, 1], "taskDone"];
	};
};

WIS_fnc_createtask = {
	PRIVATE["_locations", "_locationname"];
	task1 = player createsimpletask ["Defuse the bomb"];
	task1 setSimpleTaskDescription ["Defuse the bomb that is somewhere in the marked area", "Defuse the bomb", "Bomb"];
	[task1, "Created"] call WIS_fnc_taskstate;
	[task1, "Assigned"] call WIS_fnc_taskstate;
	player setCurrentTask task1; 
	task1 setSimpleTaskDestination (getmarkerpos "Centerpos");
	["TaskCreated",["", "Defuse the bomb"]] call BIS_fnc_showNotification;
	//taskhint ["Defuse the bomb", [1, 0, 0, 1], "taskNew"];
};

KK_fnc_inString = {
    /*
    Author: Killzone_Kid
    
    Description:
    Find a string within a string (case insensitive)
    
    Parameter(s):
    _this select 0: <string> string to be found
    _this select 1: <string> string to search in
    
    Returns:
    Boolean (true when string is found)
    
    How to use:
    _found = ["needle", "Needle in Haystack"] call KK_fnc_inString;
    */

    private ["_needle","_haystack","_needleLen","_hay","_found"];
    _needle = [_this, 0, "", [""]] call BIS_fnc_param;
    _haystack = toArray ([_this, 1, "", [""]] call BIS_fnc_param);
    _needleLen = count toArray _needle;
    _hay = +_haystack;
    _hay resize _needleLen;
    _found = false;
    for "_i" from _needleLen to count _haystack do {
        if (toString _hay == _needle) exitWith {_found = true};
        _hay set [_needleLen, _haystack select _i];
        _hay set [0, "x"];
        _hay = _hay - ["x"]
    };
    _found
};

WIS_fnc_enemy_replacement = {
	sleep 120;
	{
		if (
				alive _x 
				&& side _x == EAST 
				&& ((_x distance2d (getMarkerPos "Intel")) > 350)
				&& ((_x distance2d (getMarkerPos "camp")) > 250)
				&& ((_x distance2d Whistle_bomb) > 2000)
				&& ((_x distance2d (getmarkerpos "Oldpos")) > 2000)
			) then {
			_x setpos (getpos Whistle_bomb);
		} else {};
	} foreach allunits;
};