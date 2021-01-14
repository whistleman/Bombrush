if (!hasInterface) exitWith {};

ACE3_nearUnits = [];
ACE3_index = -1;
ACE3_LaserUnits = [];

addMissionEventHandler ["EachFrame",{
	params ["_fnc_processUnit"];

	_oldNearUnits = ACE3_nearUnits;
	ACE3_nearUnits = call ACE3_fnc_getNearUnits;

	// remove units that moved away
	{
		ACE3_LaserUnits deleteAt (ACE3_LaserUnits find _x);
	} forEach (_oldNearUnits - ACE3_nearUnits);
	
	{
		// Add units that have a laser on their weapon
		_weapon = currentWeapon player;
		_laser = [(_x weaponAccessories _weapon) select 1] param [0, ""];
		if (_laser == "acc_pointer_IR") then {
			ACE3_LaserUnits pushBackUnique _x;
		};

		// Remove units without lasers
		_weapon = currentWeapon player;
		_laser = [(_x weaponAccessories _weapon) select 1] param [0, ""];
		if (_laser == "") then {
			ACE3_LaserUnits deleteAt (ACE3_LaserUnits find _x);
		};

		// Add units that have their laser on
		if (_x isIRLaserOn currentWeapon _x) then {
			ACE3_LaserUnits pushBackUnique _x;
		};

		// Delete units that have their laser off
		if !(_x isIRLaserOn currentWeapon _x) then {
			ACE3_LaserUnits deleteAt (ACE3_LaserUnits find _x);
		};
	} foreach ACE3_nearUnits;
}];

addMissionEventHandler ["Draw3D", {call ACE3_fnc_onDraw}];

//ACE3_LaserUnits set [0,s1]