/*
	fn_CreateMarker.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		none
*/

_name = format ["_USER_DEFINED %1 %2", getpos player, diag_ticktime];
_marker = createMarker [_name, player];
_marker setMarkerType "hd_dot";
_time = [daytime, "HH:MM"] call BIS_fnc_timeToString;
_markerText = format ["%1: %2", name player, _time];
_marker setMarkerText _markerText;