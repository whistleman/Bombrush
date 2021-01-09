/*
	fn_IntelNikos.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		_handling: should Nikos mark location of bomb or location of possible terrorist camp
*/
_handling = _this select 0;

if (isServer) then {

	if (_handling) then {

		if (BR_Money_amount >= 5) then {
			BR_Money_amount = BR_Money_amount - 5;
			publicvariable "BR_Money_amount";
			Whistle_Nikos_money_amount = Whistle_Nikos_money_amount +5;
			_randomizer = (random (10));
			if (_randomizer > (Whistle_Nikos_money_amount / 5)) then {
				_maxdistance 	= call BR_fnc_GetMaxArea;
				_newPos 		= [(getmarkerpos "Respawn_west"), 3000, 30000, 1, 0, 50, 0] call BR_fnc_CheckInsideArea;
				
				_intelmrk = createmarker ["Intel", _newpos];
				_intelmrk setMarkerType "hd_objective";
				_intelmrk setmarkercolor "ColorRed";
				_now 	= date;
				_day 	= _now select 2;
				_month 	= _now select 1;
				_year 	= _now select 0;
				_hour 	= _now select 3;
				_minute = _now select 4;
				_intelmrk setMarkerText format ["Intel Nikos on terrorist camp %1-%2-%3 time: %4:%5", _day, _month, _year, _hour, _minute];
				"Intel" setMarkeralpha 1;

				_intelpatrolmrk = createmarker ["intelpatrol", _newpos];
				_intelpatrolmrk setMarkerShape "ELLIPSE";
				_intelpatrolmrk setMarkerSize [150, 150];
				"intelpatrol" setMarkeralpha 0;
				_n = 3;

				for "_x" from 1 to _n do {
				["intel" , 4, _n, ["O_Soldier_F", "O_medic_F", "O_Soldier_SL_F", "O_Soldier_AA_F", "O_soldier_exp_F"], "intelpatrol"] call BR_fnc_CreateUnits;
				};
			} else {
				"camp" setMarkeralpha 1;
			};
		} else {
			// When there isn't enough money show a hint
			[2] remoteExec ["BR_fnc_ShowHint", 0, true];
		};
	} else {
		// Show the bomb location
		if (BR_Money_amount >= 2) then {
			_bombmrk = createMarker ["_USER_DEFINED Bomb position", getpos Whistle_bomb];
			_bombmrk setMarkerText "Possible bomb location";
			_bombmrk setMarkerType "hd_destroy";
			_bombmrk setmarkercolor "ColorRed";
			_bombmrk setMarkeralpha 1;

			BR_Money_amount = BR_Money_amount - 2;
			publicvariable "BR_Money_amount";
			Whistle_Nikos_money_amount = Whistle_Nikos_money_amount + 2;
		} else {
			// When there isn't enough money show a hint
			[2] remoteExec ["BR_fnc_ShowHint", 0, true];
		};
	};
} else {
	player globalchat format ["We have %1 left", BR_Money_amount * 10000];
};