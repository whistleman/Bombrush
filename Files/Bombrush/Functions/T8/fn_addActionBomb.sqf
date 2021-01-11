_bomb = _this select 0;

_chance = ((paramsarray select 15) * 0.01);
if (random(1) > _chance) then {
	// Add action to defuse the bomb
	_id = [
		_bomb, 
		"<t color='#FFD25525'>Defuse bomb</t>", 
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", 
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", 
		"_this distance _target <= 2", 
		"_this distance _target <= 2", 
		{}, 
		{}, 
		{_this call BR_fnc_HandleActions}, 
		{}, 
		["BR_fnc_BombDefuse", false], 
		10, 
		1.5, 
		true, 
		false, 
		true
	] call BIS_fnc_holdActionAdd;

	// When the bomb is hit by a bullet, explode
	_bomb addeventhandler ["HitPart", {[_bomb select 0, 1, 30] remoteExec ["BR_fnc_DeleteAll", 0, true];[_bomb, _id] remoteExec ["BIS_fnc_holdActionRemove",WEST,true];}];
} else {
	// Add action to defuse the bomb, but the bomb is fake
	[
		_bomb, 
		"<t color='#FFD25525'>Defuse bomb</t>", 
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", 
		"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", 
		"_this distance _target <= 2", 
		"_this distance _target <= 2", 
		{}, 
		{}, 
		{_this call BR_fnc_HandleActions}, 
		{}, 
		["BR_fnc_BombDefuse", true], 
		10, 
		1.5, 
		true, 
		false, 
		true
	] call BIS_fnc_holdActionAdd;
};



