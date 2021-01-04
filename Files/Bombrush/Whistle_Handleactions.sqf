// Whistle_Handleaction.sqf
// Inspired by FAROOQ

private ["_params", "_action", "_telephone", "_caller", "_id"];

// Parameters passed by the action
_telephone 	= _this select 0;
_caller 	= _this select 1;
_id 		= _this select 2;
_params 	= _this select 3;
_action 	= _params select 0;

//
if (_action == "BR_fnc_PayMoney") then {
	[_telephone, _caller, _id] spawn BR_fnc_PayMoney;
	};

if (_action == "BR_fnc_CallNikos") then {	
	[_telephone, _caller, _id] spawn BR_fnc_CallNikos;
	};
	
if (_action == "BR_fnc_CheckBankaccount") then {	
	[_telephone, _caller, _id] spawn BR_fnc_CheckBankaccount;
};