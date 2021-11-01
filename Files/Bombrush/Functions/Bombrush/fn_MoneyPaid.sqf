if (isServer) then {
	if (alive Whistle_bomb) then {
		if (BR_Money_amount >= 10) then {
				[-10] call BR_fnc_MoneyHandler;
				Whistle_terrorist_money_amount = Whistle_terrorist_money_amount + 10;
				[Whistle_bomb, 2, 600] spawn BR_fnc_DeleteAll;
				[1] remoteExec ["BR_fnc_ShowHint", 0, true];
				["Paymoney"] remoteExec ["BR_fnc_Playsound", 0, true];
			} else {
				[2] remoteExec ["BR_fnc_ShowHint", 0, true];
			}
		} else {
	[0] remoteExec ["BR_fnc_ShowHint", 0, true];
	};
};