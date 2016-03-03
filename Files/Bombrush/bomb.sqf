//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
// bomb.sqf
//
//////////////////////////////////////////////////////////////////////////////////////////////


_intervaltime = 5;

if (!isServer) exitwith {};

_bombspawn = createMarker ["Bombspawn", [0,0,0]];
_bombarray = ["Land_Suitcase_F", "Land_LuggageHeap_02_F", "Land_LuggageHeap_01_F", "Land_MetalBarrel_F"];
Whistle_bomb = (_bombarray select (random (3))) createvehicle (getmarkerpos _bombspawn);
diag_log format ["#*# Bombrush #*# Bomb is made"];

//Get the position of the _bomb
_pos = getPosATL Whistle_bomb;

//Get an array of all the towns and select one at random
_townlist = nearestLocations [getpos Whistle_bomb, ["NameCityCapital","NameCity","NameVillage"],80000];

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


IF(count _nobjs == 0) then {
	_locationPosrnd	= [((_newpos select 0) + (sin _dir) * _dist), ((_newpos select 1) + (cos _dir) * _dist), _newpos select 2];
	_randompos 		= [_locationPosrnd, _mindist, (_dist * 2), 3, 0, 20, 0] call BIS_fnc_findSafePos;
	Whistle_bomb setposATL [_randompos select 0, _randompos select 1, 0];
} else {
	_nobj	= _nobjs select 0;
	_isenterable = [_nobj] call BIS_fnc_isBuildingEnterable;
	_nobjdamage = damage _nobj;
	IF (_isenterable && (_nobjdamage < 0.1)) then {
		_buildingposition = [_nobj] call Spliffz_fnc_buildingpos;
		diag_log format ["#*# Bombrush #*# Buildingpos is %1", _buildingposition];
		Whistle_bomb setpos (_nobj buildingpos _buildingposition);
		diag_log format ["#*# Bombrush #*# Pos Bomb is try 1 %1", getpos Whistle_bomb];
	} else {
		_locationPosrnd	= [((_newpos select 0) + (sin _dir) * _dist), ((_newpos select 1) + (cos _dir) * _dist), _newpos select 2];
		_randompos 		= [_locationPosrnd, _mindist, (_dist * 2), 3, 0, 20, 0] call BIS_fnc_findSafePos;
		Whistle_bomb setposATL [_randompos select 0, _randompos select 1, 0];
	};
};
	
	
/*
if (_nobj select 0 iskindof "house") then {
	_nobjdamage = getDammage (_nobj select 0);
	if (_nobjdamage < 0.3) then {
		[Whistle_bomb] call Tajin_fnc_buildingpos;
		diag_log format ["#*# Bombrush #*# Pos Bomb is Tajin try 1 %1", getpos Whistle_bomb];
		if ((Whistle_bomb distance [0,0,0]) < 30) then {
			Whistle_bomb setPosATL _locationPos;
			diag_log format ["#*# Bombrush #*# Pos Bomb is back to default %1", getpos Whistle_bomb];
		};
	//}
	//else {
	//_randompos = [((_newpos select 0) + (random (20)), ((_newpos select 1) + (random (20)), _newpos select 2];
	//Whistle_bomb setposATL _randompos;
	};
};
*/

diag_log format ["#*# Bombrush #*# Pos Bomb is after Buildpos %1", getpos Whistle_bomb];

sleep 2;
[Whistle_bomb ,"T8_fnc_addActionBomb", true, true] spawn BIS_fnc_MP;

_mrk = createMarker ["Bomb", _newpos];
_mrk setMarkerType "hd_dot";
_mrk setmarkercolor "ColorRed";
"Bomb" setMarkeralpha 0;

if (getMarkerColor "Oldpos" == "") then {
	_oldpos = createmarker ["Oldpos", getpos Whistle_Bomb];
	_oldpos setmarkeralpha 0;
} else {};

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
[player] call WIS_fnc_createtask;
publicvariable "Whistle_centerpos";
diag_log format ["#*# Bombrush #*# Markers made at %1, and %2", getmarkerpos _bombpatrolmrk, getmarkerpos Whistle_Areamarker];

[] call fnc_Whistle_Bombs_amount;
diag_log format ["#*# Bombrush #*# Amount of bombs is %1", Whistle_Bombs_amount];

sleep _intervaltime;

/*
if ((Whistle_Bombs_amount > 15) && (Whistle_Bombs_amount < 20) || (Whistle_Bombs_amount > 20)) then {Whistle_n = 2;};
if ((Whistle_Bombs_amount > 10) && (Whistle_Bombs_amount < 16)) then {Whistle_n = 3;};
if ((Whistle_Bombs_amount > 5) && (Whistle_Bombs_amount < 11)) then {Whistle_n = 4;};
if ((Whistle_Bombs_amount > 0) && (Whistle_Bombs_amount < 6)) then {Whistle_n = 5;};
*/

Whistle_n = paramsarray select 12;

diag_log format ["#*# Bombrush #*# Amount of bombs is %1", Whistle_Bombs_amount];
diag_log format ["#*# Bombrush #*# Whistle_n is %1", Whistle_n];

_extraunit  = floor (random (4));
_unitarray = ["O_Soldier_F", "O_medic_F", "O_Soldier_SL_F"];
_extraunitarray = ["O_Soldier_AA_F", "O_soldier_M_F"];

if (Whistle_Money_amount < ((ParamsArray select 10) / (random(2)))) then {
	_unitarray = _unitarray + _extraunitarray;
	for "_x" from 1 to Whistle_n do {
	["Bomb" , 3, _extraunit, _unitarray, "bombpatrol"] call fnc_Whistle_create_units;
	};
} else {
	for "_x" from 1 to Whistle_n do {
	["Bomb" , 3, _extraunit, _unitarray, "bombpatrol"] call fnc_Whistle_create_units;
	};
};


["[]","fnc_playsound", WEST, false] spawn BIS_fnc_MP;

publicvariable "Whistle_Bombs_amount";

[alldead] spawn BIS_fnc_GC;

if (alive Whistle_bomb) then {["Files\Bombrush\timer.sqf", "BIS_fnc_execVM", true, true] spawn BIS_fnc_MP;};
