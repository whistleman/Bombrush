/*

Spawnvehicle.sqf
To use this script follow the instructions below:

1. 	Place a marker on the map an call it (for example) "Spawnspot".
2. 	Place an object on the map and put the following code-line in the init field of the object:
	0= [this, "Spawnspot"] execVM "Files\Bombrush\Spawnvehicle.sqf";

If you want to have multiple spawn spots you will need to follow the steps mentioned above but you will need to create a new object
ánd a new marker and call it for example "Spawnspot1". Then also edit the markername in the code-line.

*/

#define WIS_PATH_ME QUOTE(Files\Bombrush\spawnvehicle.sqf)

WIS_buyablevehicles = ["Hummingbird € 80.000" , "Hunter € 30.000" , "UAV € 200.000" , "Blackhawk € 300.000"];

WIS_fnc_message = {
	PRIVATE ["_caller", "_text"];
	_caller = _this select 0;
	_text	= _this select 1;
	_caller globalchat _text;	
};

WIS_fnc_Spawn = {
	PRIVATE ["_args", "_veh", "_mrk", "_caller"];
	IF(!IsServer) exitwith {};
	_args = _this select 0;
	_veh = _args select 1;
	_mrk = _args select 2;
	_caller = _this select 1;
	_nobj	= nearestObjects [(getmarkerpos _mrk), ["TANK", "MEN", "ARMORED", "AIR"], 6];
	
	if ((count _nobj) > 0 ) exitwith {
		[_caller, "Not enough space to spawn vehicle"] remoteExec ["WIS_fnc_message", 0, true];
	};
	
	switch (_veh) do {

	case (WIS_buyablevehicles SELECT 0) :
		{
			IF (BR_Money_amount < 8) then {
				[_caller, "Not enough funds to buy this vehicle"] remoteExec ["WIS_fnc_message", 0, true];
			} else {
				"B_Heli_Light_01_F" createvehicle (getmarkerpos _mrk);
				[-8] call BR_fnc_MoneyHandler;
		};

	case (WIS_buyablevehicles SELECT 1) :
		{
			IF (BR_Money_amount < 3) then {
				[_caller, "Not enough funds to buy this vehicle"] remoteExec ["WIS_fnc_message", 0, true];
			} else {
				"B_MRAP_01_F" createvehicle (getmarkerpos _mrk);
				[-3] call BR_fnc_MoneyHandler;
			};
		};

	case (WIS_buyablevehicles SELECT 2) :
		{
			IF (BR_Money_amount < 20) then {
				[_caller, "Not enough funds to buy this vehicle"] remoteExec ["WIS_fnc_message", 0, true];
			} else {
				"B_UAV_02_F" createvehicle (getmarkerpos _mrk);
				[-20] call BR_fnc_MoneyHandler;
			};
		};

	case (WIS_buyablevehicles SELECT 3) :
		{
			IF (BR_Money_amount < 30) then {
				[_caller, "Not enough funds to buy this vehicle"] remoteExec ["WIS_fnc_message", 0, true];
			} else {
				"B_Heli_Transport_01_camo_F" createvehicle (getmarkerpos _mrk);
				[-30] call BR_fnc_MoneyHandler;
			};
		};

	};
};
};

WIS_fnc_addactions = {
	_object = _this select 0;
	_mrk	= _this select 1;
	diag_log format ["*-* Bombrush *-* addactions pre foreach with arguments: %1 , %2", _object, _mrk];
		
	_object addAction ["Buy a Hummingbird € 80.000", "Files\Bombrush\spawnvehicle.sqf", ["WIS_fnc_Spawn", "Hummingbird € 80.000", _mrk],1.5, false, true, "","",5,false];
	_object addAction ["Buy a Hunter € 30.000", "Files\Bombrush\spawnvehicle.sqf", ["WIS_fnc_Spawn", "Hunter € 30.000", _mrk],1.5, false, true, "","",5,false];
	_object addAction ["Buy a UAV € 200.000", "Files\Bombrush\spawnvehicle.sqf", ["WIS_fnc_Spawn", "UAV € 200.000", _mrk],1.5, false, true, "","",5,false];
	_object addAction ["Buy a Blackhawk € 300.000", "Files\Bombrush\spawnvehicle.sqf", ["WIS_fnc_Spawn", "Blackhawk € 300.000", _mrk],1.5, false, true, "","",5,false];

};

_object = _this select 0;

_arg = ["Init",0];
if (count(_this)>2) then {
	_arg = _this select 3;
};

switch (_arg select 0) do {

	case "Init": {
		_object = _this select 0;
		_mrk = _this select 1;
		diag_log format ["*-* Bombrush *-* WIS_fnc_addactions will be called..."];
		[_object, _mrk] call WIS_fnc_addactions;
		diag_log format ["*-* Bombrush *-* WIS_fnc_addactions called with following params: %1, %2", _object, _mrk];
	};

	case "WIS_fnc_Spawn": {
		diag_log format ["*-* Bombrush *-* WIS_fnc_Spawn is being called..."];
		_caller = _this select 1;
		[_arg, _caller] remoteExec ["WIS_fnc_Spawn", 0, true];
		diag_log format ["*-* Bombrush *-* WIS_fnc_Spawn called arguments: %1, %2", _caller, _arg];
	};
};