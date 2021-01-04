/*
	fn_CreateUnits.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		select 0:	Marker where to spawn(String)able
		select 1:	Amount of units spawned
		select 2:   Random amount extra spawned
		select 3:	Array of units that the script chooses from
		select 4: 	marker to patrol (string)
*/

_grp			= CreateGroup EAST;
_n 				= (_this select 1) + random (_this select 2);
_unitarray 		= _this select 3;
_skill 			= paramsarray select 6;

for "_x" from 1 to _n do {
        _unitInGroup = (_unitarray select (floor (random ((count _unitarray) - 1)))) createUnit [getmarkerpos (_this select 0), _grp];
};

{
	[_x, _skill] call EGG_fnc_EVO_skill;
} foreach units _grp;

[_grp] call spliffz_terror_gear_unit; // Functionize??

_nobj = nearestObjects [(getmarkerpos (_this select 0)), ["House"], 20];
if ((count _nobj) > 3) then {
	_nul = [_grp, 50, false,	[60,1], false, true] execVM "files\AI\Garrison_script.sqf";
	} else {
		if (!isNil "BR_Money_amount") then {
			if (BR_Money_amount < ((ParamsArray select 10) / (random(2)))) then {
				if ((random (10)) > 2) then {
					_posveh = [(getmarkerpos "Bomb"), 5, 35, 3, 0, 20, 0] call BIS_fnc_findSafePos;
					_veh = "B_G_Offroad_01_armed_F" createvehicle _posveh;
					_grp addVehicle _veh;
					_wp = _grp addWaypoint [position _veh, 0];
					_wp setWaypointType "GETIN";
				};
			};
		};
	[([_grp] call spliffz_fnc_makeArrayFromGroup), _this select 4,"random"] execVM "files\AI\UPS.sqf";
	};
if ((daytime > 19.15) && (5 < daytime)) then {_grp enableGunLights "forceOn";};