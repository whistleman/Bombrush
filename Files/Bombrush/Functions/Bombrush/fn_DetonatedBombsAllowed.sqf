Whistle_detonatedbombsallowed = Whistle_detonatedbombsallowed - 1;
if (Whistle_detonatedbombsallowed  == 0) then {
	"LOSER" call BIS_fnc_endMission;
};