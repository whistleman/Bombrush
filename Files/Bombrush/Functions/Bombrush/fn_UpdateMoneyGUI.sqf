disableSerialization;

// Put display and control in local variable
_display = findDisplay 46;

_ctrl = _display displayCtrl 9292;

// Check which side the player is one
_money = BR_Money_amount;
_moneyFormatted = format ["€ %1", _money * 10000];

_ctrl ctrlSetText _moneyFormatted;

_ctrl ctrlCommit 0;