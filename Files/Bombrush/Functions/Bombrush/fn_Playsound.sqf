_sound = _this select 0;

if (_sound == "Plantedbomb") then {
	playsound "Plantedbomb"; 
	sleep 3.5;
	cutText ["A Mysterious voice says: We have planted a bomb","PLAIN",2];
};
if (_sound == "Nikos") then {
	playsound "Nikos"; 
	sleep 6;
	cutText ["Nikos here, I have placed a marker on your map","PLAIN",2];
};
if (_sound == "Paymoney") then{
	playsound "Paymoney"; 
	sleep 3;
	cutText ["A Mysterious voice says: We have planted a bomb","PLAIN",2];
};