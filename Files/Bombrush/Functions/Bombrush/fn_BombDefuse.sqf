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

if !(_fake) then {
	// There is always a chance the bomb will explode
	_engineers = WIS_array_defusers;
	_chance = if (typeof _caller in _engineers) then {0.05} else {0.5};
	if ((random (1)) > _chance) then {
		// When above chance defuse
		[_bomb, 0, 30] remoteExec ["BR_fnc_DeleteAll", 0, true];
		[_bomb, _id] remoteExec ["BIS_fnc_holdActionRemove",WEST,true];
	} else {
		// When below chance, explode
		[_bomb, 1, 30] remoteExec ["BR_fnc_DeleteAll", 0, true];
		[_bomb, _id] remoteExec ["BIS_fnc_holdActionRemove",WEST,true];
	};
} else {
	// When a fake bomb
	[_bomb, 3, 0] remoteExec ["BR_fnc_DeleteAll", 0, true];
	[_bomb, _id] remoteExec ["BIS_fnc_holdActionRemove",WEST,true];
};

