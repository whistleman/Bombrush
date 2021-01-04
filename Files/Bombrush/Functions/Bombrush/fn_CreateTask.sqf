_nearestLocations = nearestLocations [getmarkerpos "Centerpos", ["Airport","NameLocal","NameVillage","NameCity","NameCityCapital","NameMarine"], 500];
_locationName = text (_nearestLocations select 0);
_taskName = format ["Defuse the bomb at %1", _locationName];
_taskDescription = format ["Defuse the bomb that is somewhere in the marked area in %1", _locationName];
_taskMarkerName = format ["Bomb"];

[WEST, [_taskName], [_taskDescription,_taskName,_taskMarkerName], (getmarkerpos "Centerpos"), true, -1, true, "destroy", false] call BIS_fnc_taskCreate;

_task = player call BIS_fnc_taskCurrent;