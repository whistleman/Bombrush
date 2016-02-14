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
if (_action == "fnc_Pay_Money") then {
	[_telephone, _caller, _id] spawn fnc_Pay_Money;
	};

if (_action == "fnc_call_Nikos") then {	
	[_telephone, _caller, _id] spawn fnc_call_Nikos;
	};
	
if (_action == "fnc_check_bankaccount") then {	
	[_telephone, _caller, _id] spawn fnc_check_bankaccount;
};