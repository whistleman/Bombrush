//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
// createcamps.sqf
//
//
//////////////////////////////////////////////////////////////////////////////////////////////

"BR_Bombs_amount" addPublicVariableEventHandler {
	[] call BR_fnc_CreateTask;
};

if (!isServer) exitwith {};

_areaSize = paramsarray select 13;
_locations 		= nearestLocations [(getmarkerpos "Respawn_west"), ["NameLocal"],_areaSize];
//_rnd 			= floor random (count _locations);
//_pos	 		= _locations select _rnd;
_newPos 		= [(getmarkerpos "Respawn_west"), 750, _areaSize, 2, 0, 20, 0] call BR_fnc_CheckInsideArea;
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

// add actions to telephone pole
Whistle_telephone remoteExec ["T8_fnc_addActionsTelephone", 0, true];


//Create the camps with the groups and the leader
_HQ 			= createCenter EAST;

// Create a marker fo the patrols
_patrolmrk = createmarker ["camppatrol", (getmarkerpos "camp")];
_patrolmrk setMarkerShape "ELLIPSE";
_patrolmrk setMarkerSize [150, 150];
"camppatrol" setMarkeralpha 0;

_n = 2; 

for "_x" from 1 to _n do {
["camp" , 4, _n, ["O_Soldier_F", "O_medic_F", "O_Soldier_SL_F", "O_Soldier_AA_F", "O_soldier_exp_F"], "camppatrol"] call BR_fnc_CreateUnits;
};

// Create the campleader that has to be killed
_campleadergroup = CreateGroup EAST;
Whistle_campleader = _campleadergroup createunit ["O_Story_CEO_F", getmarkerpos "camp", [], 0, "FORM"];
Whistle_campleader disableAI "MOVE"; 
removeHeadgear Whistle_campleader;
Whistle_campleader addHeadgear "H_Beret_red";
Whistle_skill = paramsarray select 6;
[Whistle_campleader, Whistle_skill] call EGG_fnc_EVO_skill;
Whistle_campleader addMPEventHandler ["MPkilled", {[] call BR_fnc_EndMission}];

// Create a camonet near the Hidingplace
"CamoNet_OPFOR_F" createVehicle (getmarkerpos "camp");

BR_Bombs_amount = ParamsArray select 4;
BR_Money_amount = ParamsArray select 10;
Whistle_terrorist_money_amount = 0;
Whistle_Nikos_money_amount = 0;
publicvariable "BR_Money_amount";
Whistle_detonatedbombsallowed = ParamsArray select 5;

_intervaltime = paramsarray select 8;
									

if ((alive Whistle_campleader) && (isNil "Whistle_bomb")) then {sleep _intervaltime; [] execVM "Files\Bombrush\bomb.sqf"; sleep 10};

