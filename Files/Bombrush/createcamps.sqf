//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
// createcamps.sqf
//
//
//////////////////////////////////////////////////////////////////////////////////////////////


WIS_task_fetch	= 0;

"Whistle_Bombs_amount" addPublicVariableEventHandler {
	[] call WIS_fnc_createtask;
};

"WIS_task_fetch" addPublicVariableEventHandler {
	[task1, "Succeeded"] call WIS_fnc_taskstate;
};

if (!isServer) exitwith {};

_locations 		= nearestLocations [(getmarkerpos "Respawn_west"), ["NameLocal"],30000];
//_rnd 			= floor random (count _locations);
//_pos	 		= _locations select _rnd;
_newPos 		= [(getmarkerpos "Respawn_west"), 3000, 30000, 2, 0, 20, 0] call WIS_fnc_Check_Inside_Area;
_camppos		= _newpos;

//Create the marker
_mrk = createMarker ["camp", _camppos];
_mrk setMarkerType "hd_dot";
_mrk setmarkercolor "ColorRed";
"camp" setMarkeralpha 0;


//Spawn telephone booth so you can call the bank to transfer money to the terrorists
_posbase 		= getmarkerpos "Respawn_west";
_telephone_pos 	= [((_posbase select 0)) - 2, ((_posbase select 1) + 5), _posbase select 2];
Whistle_telephone = createVehicle ["Land_PhoneBooth_02_F", _telephone_pos, [], 0, "CAN_COLLIDE"];
Whistle_telephone setDir ((getdir ammobox1) - 90);
Whistle_telephone setPosATL _telephone_pos;


Whistle_telephone allowdamage false;

//On Altis, i put this on a nice location on the base... If you want this to spawn near you, use the code above. Just comment or delete below.
//_telephone_pos = [14167.4,16276.5,0.00435829];
//Whistle_telephone = createVehicle ["Land_PhoneBooth_02_F", _telephone_pos, [], 0, "CAN_COLLIDE"];
//Whistle_telephone setDir 312;
//Whistle_telephone setPosATL _telephone_pos;

SLEEP 2;
[Whistle_telephone ,"T8_fnc_addActionTelephoneNikos", true, true] spawn BIS_fnc_MP;
sleep 1;
[Whistle_telephone ,"T8_fnc_addActionTelephoneBank", true, true] spawn BIS_fnc_MP;
sleep 1;
[Whistle_telephone ,"T8_fnc_addActionTelephoneBalance", true, true] spawn BIS_fnc_MP;
Whistle_skill = paramsArray select 6;

//Create the camps with the groups and the leader
_HQ 			= createCenter EAST;

_patrolmrk = createmarker ["camppatrol", (getmarkerpos "camp")]; // was getmarkerpos "camppos"??
_patrolmrk setMarkerShape "ELLIPSE";
_patrolmrk setMarkerSize [150, 150];
"camppatrol" setMarkeralpha 0;

_n = 2; 

for "_x" from 1 to _n do {
["camp" , 4, _n, ["O_Soldier_F", "O_medic_F", "O_Soldier_SL_F", "O_Soldier_AA_F", "O_soldier_exp_F"], "camppatrol"] call fnc_Whistle_create_units;
};

// Create the campleader that has to be killed
_campleadergroup = CreateGroup EAST;
Whistle_campleader = _campleadergroup createunit ["O_Story_CEO_F", getmarkerpos "camp", [], 0, "FORM"];
Whistle_campleader disableAI "MOVE"; 
removeHeadgear Whistle_campleader;
Whistle_campleader addHeadgear "H_Beret_red";
[Whistle_campleader, Whistle_skill] call EGG_EVO_skill;
Whistle_campleader addMPEventHandler ["MPkilled", {[] call WIS_fnc_end_mission}];

// Create a camonet near the Hidingplace
"CamoNet_OPFOR_F" createVehicle (getmarkerpos "camp");

Whistle_Bombs_amount = ParamsArray select 4;
Whistle_Money_amount = ParamsArray select 10;
Whistle_terrorist_money_amount = 0;
Whistle_Nikos_money_amount = 0;
publicvariable "Whistle_Money_amount";
Whistle_detonatedbombsallowed = ParamsArray select 5;

_intervaltime = paramsarray select 8;
									

if ((alive Whistle_campleader) && (isNil "Whistle_bomb")) then {sleep _intervaltime; [] execVM "Files\Bombrush\bomb.sqf"; sleep 10};

