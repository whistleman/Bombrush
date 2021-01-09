/*
	fn_addActionsPlayer.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		none
*/

if (hasInterface) then {
	player addaction ["Mark current position", {_this call BR_fnc_HandleActions}, ["BR_fnc_CreateMarker"],1.5, false, true, "","_this == _originalTarget",-1,false];
};