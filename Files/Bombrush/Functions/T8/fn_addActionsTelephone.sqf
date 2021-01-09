_this addAction ["Check your bank account",{_this call BR_fnc_HandleActions}, ["BR_fnc_CheckBankaccount"],1.5, false, true, "","",2,false];
_this addAction ["Pay terorrists $ 100.000", {_this call BR_fnc_HandleActions}, ["BR_fnc_PayMoney"],1.5, false, true, "","",2,false];
_this addAction ["Call Nikos for intel in terrorist camp $ 50.000", {_this call BR_fnc_HandleActions}, ["BR_fnc_CallNikosCamp"],1.5, false, true, "","",2,false];
_this addAction ["Call Nikos for intel on bomb location $ 20.000", {_this call BR_fnc_HandleActions}, ["BR_fnc_CallNikosBomb"],1.5, false, true, "","",2,false];