
if (isServer) then {
	//if (getMarkerColor "Intel" == "") then {} else {deletemarker "Intel"; deletemarker "intelpatrol"; };
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
				_intelmrk setMarkerText format ["Intel Nikos %1-%2-%3 time: %4:%5", _day, _month, _year, _hour, _minute];
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
		};
	} else {
	player globalchat format ["We have %1 left", BR_Money_amount * 10000]};