if (BR_Bombs_amount > 0) then {
	[] execVM "Files\Bombrush\bomb.sqf";
} else {
	"LOSER" call BIS_fnc_endMission;
};