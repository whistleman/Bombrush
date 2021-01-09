params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];

if (_oldUnit == objNull) exitwith {};

// Fatigue
_fatigue = if (paramsarray select 14 == 1) then {true} else {false};
player enableFatigue _fatigue;

// If player died while defusing the bomb make sure he can play again
player enablesimulation true;
disableUserInput false;

// get gear from old unit
_oldLoadout = getUnitLoadout [_oldUnit, true];

// put gear on new unit
_newUnit setUnitLoadout [_oldLoadout,true];