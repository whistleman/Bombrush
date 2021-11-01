// Do not execute on server
if !(hasInterface) exitWith {};

disableSerialization;

waituntil {!isNull findDisplay 46};
waitUntil {!IsNil "BR_Money_amount"};

// Check which side the player is on
_money = BR_Money_amount;
_moneyFormatted = format ["€ %1", _money * 10000];

_display = findDisplay 46;
_color = [0.1,1.0,0.1,1.0];

private _control = _display ctrlCreate ["RscText", -1];

_control ctrlSetText "Money:";
_control ctrlSetTextColor _color;

_control ctrlSetPosition [
	safezoneX + safezoneW * 0.644375, 
	safezoneY + safezoneH * 0.027, 
	safezoneW * 0.06,
	safezoneH * 0.03
];
_control ctrlSetScale 0.8;
_control ctrlCommit 0;

if (ctrlText (_display displayctrl 9292) == "") then {
	private _ctrlMoney = _display ctrlCreate ["RscText", 9292];

	_ctrlMoney ctrlSetText _moneyFormatted;
	_ctrlMoney ctrlSetTextColor _color;

	_ctrlMoney ctrlSetPosition [
		safezoneX + safezoneW * 0.721094,
		safezoneY + safezoneH * 0.027,
		safezoneW * 0.0721875,
		safezoneH * 0.03
	];
	_ctrlMoney ctrlSetScale 0.8;
	_ctrlMoney ctrlCommit 0;
};