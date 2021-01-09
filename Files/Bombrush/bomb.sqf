//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
// bomb.sqf
//
//////////////////////////////////////////////////////////////////////////////////////////////

if (!isServer) exitwith {};

_bombspawn = createMarker ["Bombspawn", [0,0,0]];

_bombarray = ["Land_Suitcase_F","Land_LuggageHeap_02_F","Land_LuggageHeap_01_F","Land_MetalBarrel_F","Land_MetalCase_01_small_F","Land_PlasticCase_01_medium_F","Land_PlasticCase_01_medium_black_F","Land_PlasticCase_01_medium_gray_F","Land_PlasticCase_01_medium_olive_F","Land_PlasticCase_01_small_F","Land_PlasticCase_01_small_black_F"];

// TODO: Make sure random 3 will be random lenght array
Whistle_bomb = (selectRandom _bombarray) createvehicle (getmarkerpos _bombspawn);
diag_log format ["#*# Bombrush #*# Bomb is made"];

//Get the position of the _bomb
_pos = getPosATL Whistle_bomb;

//Get an array of all the towns and select one at random
_areaSize = paramsarray select 13;
_townlist = nearestLocations [getmarkerpos "respawn_west", ["NameCityCapital","NameCity","NameVillage"],_areaSize];

//Get town from array
_rnd = floor random (count _townlist);
_town = _townlist select _rnd;
_town_name = text (_town);

//Get town location
_dir			= (random(360));
_mindist		= 15;
_dist			= 30;
_location 	 	= locationPosition (_town);
_locationPos 	= [_location select 0, _location select 1, 0];
_locationPosrnd = [_locationPos, _mindist, (_dist * 2), 3, 0, 20, 0] call BIS_fnc_findSafePos;
diag_log format ["#*# Bombrush #*# Location pos rnd Bomb is %1", _locationPosrnd ];

//Move bomb to town location
Whistle_bomb setPosATL [_locationPosrnd select 0, _locationPosrnd select 1, 0];

//Get pos for marker
_newpos = getPosATL Whistle_bomb;
diag_log format ["#*# Bombrush #*# Pos Bomb is %1", _newpos];
_nobjs 	= nearestObjects [Whistle_bomb, ["house"], _dist];
diag_log format ["#*# Bombrush #*# Nobjs is %1", _nobjs];

// Put the bomb at a position inside a building. If that does not work, place it on a random position
IF(count _nobjs == 0) then {
	_locationPosrnd	= [((_newpos select 0) + (sin _dir) * _dist), ((_newpos select 1) + (cos _dir) * _dist), _newpos select 2];
	_randompos 		= [_locationPosrnd, _mindist, (_dist * 2), 3, 0, 20, 0] call BIS_fnc_findSafePos;
	Whistle_bomb setposATL [_randompos select 0, _randompos select 1, 0];
} else {
	_nobj	= _nobjs select 0;
	_isenterable = [_nobj] call BIS_fnc_isBuildingEnterable;
	_nobjdamage = damage _nobj;
	IF (_isenterable && (_nobjdamage < 0.1)) then {
		_buildingposition = [_nobj] call spliffz_fnc_buildingpos;
		diag_log format ["#*# Bombrush #*# Buildingpos is %1", _buildingposition];
		Whistle_bomb setpos (_nobj buildingpos _buildingposition);
		diag_log format ["#*# Bombrush #*# Pos Bomb is try 1 %1", getpos Whistle_bomb];
	} else {
		_locationPosrnd	= [((_newpos select 0) + (sin _dir) * _dist), ((_newpos select 1) + (cos _dir) * _dist), _newpos select 2];
		_randompos 		= [_locationPosrnd, _mindist, (_dist * 2), 3, 0, 20, 0] call BIS_fnc_findSafePos;
		Whistle_bomb setposATL [_randompos select 0, _randompos select 1, 0];
	};
};

diag_log format ["#*# Bombrush #*# Pos Bomb is after Buildpos %1", getpos Whistle_bomb];

Whistle_bomb remoteExec ["T8_fnc_addActionBomb", 0, true];

_mrk = createMarker ["Bomb", _newpos];
_mrk setMarkerType "hd_dot";
_mrk setmarkercolor "ColorRed";
"Bomb" setMarkeralpha 0;

if (getMarkerColor "Oldpos" == "") then {
	_oldpos = createmarker ["Oldpos", getpos Whistle_Bomb];
	_oldpos setmarkeralpha 0;
};

_bombpatrolmrk = createmarker ["bombpatrol", _newpos];
_bombpatrolmrk setMarkerShape "ELLIPSE";
_bombpatrolmrk setMarkerSize [100, 100];
_bombpatrolmrk setMarkerBrush "Grid";
_bombpatrolmrk setMarkeralpha 0;

Whistle_Areamarker = createmarker ["Areamarker", _newpos];
Whistle_Areamarker setMarkerShape "ELLIPSE";
Whistle_Areamarker setMarkerSize [100, 100];
Whistle_Areamarker setMarkerBrush "Grid";
Whistle_Areamarker setmarkercolor "ColorRed";
Whistle_Areamarker setMarkeralpha 1;
Whistle_centerpos = createmarker ["Centerpos", _newpos];
publicvariable "Whistle_centerpos";

[player] remoteExec ["BR_fnc_CreateTask", WEST, true];

diag_log format ["#*# Bombrush #*# Markers made at %1, and %2", getmarkerpos _bombpatrolmrk, getmarkerpos Whistle_Areamarker];

BR_Bombs_amount = BR_Bombs_amount - 1;
diag_log format ["#*# Bombrush #*# Amount of bombs is %1", BR_Bombs_amount];

_intervaltime = 5;
sleep _intervaltime;

Whistle_n = paramsarray select 12;

diag_log format ["#*# Bombrush #*# Amount of bombs is %1", BR_Bombs_amount];
diag_log format ["#*# Bombrush #*# Whistle_n is %1", Whistle_n];

_extraunit  = floor (random (4));
_unitarray = ["O_Soldier_F", "O_medic_F", "O_Soldier_SL_F"];
_extraunitarray = ["O_Soldier_AA_F", "O_soldier_M_F"];

if (BR_Money_amount < ((ParamsArray select 10) / (random(2)))) then {
	_unitarray = _unitarray + _extraunitarray;
	for "_x" from 1 to Whistle_n do {
	["Bomb" , 3, _extraunit, _unitarray, "bombpatrol"] call BR_fnc_CreateUnits;
	};
} else {
	for "_x" from 1 to Whistle_n do {
	["Bomb" , 3, _extraunit, _unitarray, "bombpatrol"] call BR_fnc_CreateUnits;
	};
};

["PlantedBomb"] remoteExec ["BR_fnc_Playsound", WEST, false];

publicvariable "BR_Bombs_amount";

[alldead] spawn BIS_fnc_GC;

if (alive Whistle_bomb) then {
		"Files\Bombrush\timer.sqf" remoteExec ["BIS_fnc_execVM", 0, true]
	} else {
		diag_log format ["#*# Bombrush #*# Could not spawn bomb"];
}