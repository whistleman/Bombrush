/*
	fn_CallNikos.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		_target:	see addaction syntax
		_caller:	see addaction syntax
		_id	:		see addaction syntax
		_handling:	whether nikos should show mark where the bomb is, or where the enemy camp is hidden
*/

_target 	= _this select 0;
_caller 	= _this select 1;
_id 		= _this select 2;
_handling 	= _this select 3;

["Nikos"] remoteExec ["BR_fnc_Playsound", WEST, false];
[_handling] remoteExec ["BR_fnc_IntelNikos", 0, true];