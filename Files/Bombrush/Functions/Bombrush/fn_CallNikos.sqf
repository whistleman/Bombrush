_telephone = _this select 0;
_caller = _this select 1;
_id = _this select 2;

["Nikos"] remoteExec ["BR_fnc_Playsound", WEST, false];
[] remoteExec ["BR_fnc_IntelNikos", 0, true];