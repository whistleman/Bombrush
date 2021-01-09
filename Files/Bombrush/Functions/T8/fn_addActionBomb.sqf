_chance = ((paramsarray select 15) * 0.01);
if (random(1) > _chance) then {
	// When the bomb is hit by a bullet, explode
	_this addeventhandler ["HitPart", {[_this select 0, 1, 30] remoteExec ["BR_fnc_DeleteAll", 0, true];}];

	// Add action to defuse the bomb
	_this addAction ["Defuse bomb", {_this call BR_fnc_HandleActions}, ["BR_fnc_BombDefuse", false],1.5, false, true, "","",2,false];
} else {
	// Add action to defuse the bomb, but the bomb is fake
	_this addAction ["Defuse bomb", {_this call BR_fnc_HandleActions}, ["BR_fnc_BombDefuse", true],1.5, false, true, "","",2,false];
};
