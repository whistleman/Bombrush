if (BR_Bombs_amount == 0) then {
	"LOSER" call BIS_fnc_endMission;
};
if ((not alive Whistle_bomb) && (BR_Bombs_amount > 0) && (isNull Whistle_bomb)) then {
	[] execVM "Files\Bombrush\bomb.sqf";
};