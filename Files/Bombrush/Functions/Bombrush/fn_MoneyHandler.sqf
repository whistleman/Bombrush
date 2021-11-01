// Amount coming in
_amount = _this select 0;

// Mutate the money
BR_Money_amount = BR_Money_amount + _amount;

// Broadcast across clients and server
publicVariable "BR_Money_amount";

// Update GUI remotely
[] remoteExec ["BR_fnc_UpdateMoneyGUI",[0,-2] select isDedicated,true];