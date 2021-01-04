/*
	EnemyReplacement.sqf
	Written by: Whistleman
	For: Bombrush
	Description: This function replaces all enemy units to the new bomb site as soon as 
	incoming params:
		select 0:	array of units
*/

_units = _this select 0;

// First sleep for 120 seconds. Usually the players will already have left after 2 minutes.
sleep 120;

// Delete all the dead enemies from array
_groupsArray = [];
_unitTypes = [];
{
	// Check if unit is alive
	if (alive _x) then {
		// 
		_group = group _x;
		if !(_group in _groupsArray) then {
			_groupsArray append [_group];
		};

		// Add unittype to array
		_unitType = typeOf _x;
		if !(_unitType in _unitTypes) then {
			_unitTypes append [_unitType];
		};
	};
} forEach _units;

diag_log format ["#*# Bombrush #*# Groups Array: %1",_groupsArray];
diag_log format ["#*# Bombrush #*# Unittypes: %1",_unitTypes];

// Loop through groups and let the create units function create the new units
{
	_groupSize = count "units group _x";
	["Bomb" , _groupSize, 0, _unitTypes, "bombpatrol"] call BR_fnc_CreateUnits;
} forEach _groupsArray;

// Delete old enemy units
{
	deleteVehicle _x;
} forEach _units;