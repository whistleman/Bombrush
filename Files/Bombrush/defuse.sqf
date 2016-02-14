//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
// defuse.sqf
//
//////////////////////////////////////////////////////////////////////////////////////////////

_bomb 	= _this select 0;
_caller = _this select 1;
_id 	= _this select 2;

_caller removeaction _id;

if ((_caller distance _bomb) < 2) then {

	_engineers = WIS_array_defusers;
	_caller addEventHandler ["hit", {Whistle_INIT_defuse = false;}];

	Whistle_INIT_defuse = true;
	//_caller playmove "AmovPknlMstpSrasWrflDnon_gear";
	
	disableUserInput true;
	
	_caller playmove "AinvPknlMstpSnonWnonDnon_medic_1";
	sleep 10;

	disableUserInput false;

	if (Whistle_INIT_defuse) then {
		if (typeof _caller in _engineers) then {
			[[_bomb, 0, 30, 1], "fnc_Whistle_delete_all", true, true] spawn BIS_fnc_MP; 
			Whistle_INIT_defuse = false; 
			publicvariable "Whistle_INIT_defuse"; 
			_bomb removeaction _id;
			} else {
				if ((random (1)) > 0.5) then {
					[[_bomb, 1, 30, 0], "fnc_Whistle_delete_all", true, true] spawn BIS_fnc_MP;
					Whistle_INIT_defuse = false; 
					publicvariable "Whistle_INIT_defuse"; 
					_bomb removeaction _id;
					} else {
					[[_bomb, 0, 30, 1], "fnc_Whistle_delete_all", true, true] spawn BIS_fnc_MP;
					Whistle_INIT_defuse = false; 
					publicvariable "Whistle_INIT_defuse"; 
					_bomb removeaction _id;				
					};
			};
	} else {
		player globalchat "Defusal cancelled";
	};
} else {
player globalchat "Get closer to the bomb!";
};