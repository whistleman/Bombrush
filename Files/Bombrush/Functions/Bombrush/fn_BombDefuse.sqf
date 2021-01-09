/*
	fn_BombDefuse.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		_bomb    the bomb object
		_caller  the player that called the action
		_id 	 id of action
		_fake 	 true / false if the bomb is fake
*/

_bomb 	= _this select 0;
_caller = _this select 1;
_id 	= _this select 2;
_fake	= _this select 3;

// _caller removeaction _id; does not do anyting?

_engineers = WIS_array_defusers;
_caller addEventHandler ["hit", {Whistle_INIT_defuse = false;}];

Whistle_INIT_defuse = true;
//_caller playmove "AmovPknlMstpSrasWrflDnon_gear";

disableUserInput true;

_caller playmove "AinvPknlMstpSnonWnonDnon_medic_1";
sleep 10;

disableUserInput false;

if !(_fake) then {
	if (Whistle_INIT_defuse) then {
	// There is always a chance the bomb will explode
	_chance = if (typeof _caller in _engineers) then {0.05} else {0.5};
		if ((random (1)) > _chance) then {
			// When above chance defuse
			[_bomb, 0, 30] remoteExec ["BR_fnc_DeleteAll", 0, true];
			Whistle_INIT_defuse = false; 
			publicvariable "Whistle_INIT_defuse"; 
			_bomb removeaction _id;	
		} else {
			// When below chance, explode
			[_bomb, 1, 30] remoteExec ["BR_fnc_DeleteAll", 0, true];
			Whistle_INIT_defuse = false; 
			publicvariable "Whistle_INIT_defuse"; 
			_bomb removeaction _id;	
		};
	} else {
		player globalchat "Defusal cancelled";
	};
} else {
	// When a fake bomb
	[_bomb, 3, 0] remoteExec ["BR_fnc_DeleteAll", 0, true];
	Whistle_INIT_defuse = false; 
	publicvariable "Whistle_INIT_defuse"; 
	_bomb removeaction _id;	
};

