/*
	fn_HandleActions.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
	_target
	_caller
	_id
	_args
	_action
*/

private ["_args", "_action", "_target", "_caller", "_id"];

// Parameters passed by the action
_target 	= _this select 0;
_caller 	= _this select 1;
_id 		= _this select 2;
_args 		= _this select 3;
_action 	= _args select 0;

//
switch (_action) do {
	case "BR_fnc_PayMoney": {
		[_target, _caller, _id] spawn BR_fnc_PayMoney;
	};
	case "BR_fnc_CallNikosCamp": {
		[_target, _caller, _id, true] spawn BR_fnc_CallNikos;
	};
	case "BR_fnc_CallNikosBomb": {
		[_target, _caller, _id, false] spawn BR_fnc_CallNikos;
	};
	case "BR_fnc_CheckBankaccount": {
		[_target, _caller, _id] spawn BR_fnc_CheckBankaccount;
	};
	case "BR_fnc_BombDefuse": {
		_fake = _args select 1;
		[_target, _caller, _id, _fake] spawn BR_fnc_BombDefuse;
	};
	case "BR_fnc_CreateMarker": {
		[_target, _caller, _id] spawn BR_fnc_CreateMarker;
	};
	default {
		systemChat "No valid action found";
	};
};