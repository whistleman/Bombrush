//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush v1.2.6
// timer.sqf
// Credits to mindstorm for his timer
//
//////////////////////////////////////////////////////////////////////////////////////////////



if (isServer) then {
	if (paramsarray select 7 == 1) then {
	
		Whistle_cnt_units 			= {alive _x && side _x == WEST} count playableunits;
		Whistle_cnt_enemy_units 	= {alive _x && side _x == EAST} count allunits;
		
		diag_log format ["#*# Whistle #*# BLUFOR Units %1", Whistle_cnt_units];
		diag_log format ["#*# Whistle #*# OPFOR Units %1", Whistle_cnt_enemy_units ];
		
		if (Whistle_cnt_units > 1) then {
			{
				_dist 			= _x distance2D Whistle_bomb;
				_totaldistance 	= _totaldistance + _dist;
			} foreach playableunits;
			Whistle_totaldistance = ((_totaldistance / Whistle_cnt_units) / 1000);
			
			diag_log format ["#*# Whistle #*# Total distance %1", Whistle_totaldistance];
		} else {
			Whistle_totaldistance = (((getMarkerPos "Respawn_west") distance2D Whistle_bomb) / 1000);
			diag_log format ["#*# Whistle #*# Total distance %1", Whistle_totaldistance];
		};	
		
		// add at least 10 minutes to the clock so you have enough time to go from the old place to the vehicle
		_mintime = 600;
		// when you fly with a chopper, every minute you fly 4 km so that is why i multiplied total distance by 0.25
		// add the amount of enemies times 1/3 as extra time to kill enemies when near the bomb
		END_TIME = _mintime + (ceil(Whistle_totaldistance * 60 * 0.25)) + (Whistle_cnt_enemy_units * 60 * 0.33); 
		diag_log format ["*-* Bombrush *-* End_time"];
		publicvariable "END_TIME";	
		
	} else {
	
		END_TIME = paramsarray select 7;
		publicvariable "END_TIME";
		
	};
};

waituntil {!isNil "END_TIME"};

if (isServer) then {
	[] spawn 
	{
		ELAPSED_TIME = 0;
		START_TIME = diag_tickTime;
		Whistle_INIT_TIMER = true;
		while {(ELAPSED_TIME < END_TIME) && (Alive Whistle_Bomb) && (Whistle_INIT_TIMER) && (Whistle_cnt_units > 0)} do 
		{
			ELAPSED_TIME = diag_tickTime - START_TIME;
			publicVariable "ELAPSED_TIME";
			sleep 1;
		};
	if ((ELAPSED_TIME > END_TIME) && (Whistle_INIT_TIMER)) then {[Whistle_bomb, 1, 60, 0] spawn fnc_Whistle_delete_all;};
	};
};


if!(isDedicated) then
{
	[] spawn 
	{	
		sleep 1;
		waituntil {!isNil "ELAPSED_TIME"};
		while{ELAPSED_TIME < END_TIME } do
		{
			_time = END_TIME - ELAPSED_TIME;
			_finish_time_minutes = floor(_time / 60);
			_finish_time_seconds = floor(_time) - (60 * _finish_time_minutes);
			if(_finish_time_seconds < 10) then
			{
				_finish_time_seconds = format ["0%1", _finish_time_seconds];
			};
			if(_finish_time_minutes < 10) then
			{
				_finish_time_minutes = format ["0%1", _finish_time_minutes];
			};
			Whistle_formatted_time = format ["%1:%2", _finish_time_minutes, _finish_time_seconds];
			
			//hintSilent format ["Time left:\n%1", Whistle_formatted_time];
			sleep 1;
		};
	};
};

if (isServer) exitwith {};
sleep 3;
disableSerialization;
// get current compass heading
TacVision_getCurrentCompassHeading = {
    private ["_dir", "_hud", "_ui"];
    disableSerialization;
    _ui = _this select 0;
    _hud = _this select 1;
	while {true} do {
        _hud ctrlSetText Whistle_formatted_time;
        _hud ctrlCommit 0;
    };
};

// GUI For timer
17201 cutRsc ["BOMB_RUSH_UI", "PLAIN", 1, false];
_ui = uiNamespace getVariable "BOMB_RUSH_GUI";
//diag_log format ["#*# Whistle #*# uinamespace: %1", (uiNameSpace getVariable "BOMB_RUSH_GUI")];
_idc = 17770;
_hud = _ui displayCtrl _idc;
_hud ctrlSetFade 0;
_hud ctrlCommit 0;
[_ui, _hud] spawn TacVision_getCurrentCompassHeading;

17202 cutRsc ["Whistle_Timer_PAA", "PLAIN", 1, false];
// GUI For picture
_hud = _ui displayCtrl 18770;
_hud ctrlSetFade 0;
_hud ctrlCommit 0;