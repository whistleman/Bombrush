/*
	fn_DeleteAll.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		select 0:	the current bomb / should be Whistle_bomb variable
		select 1:	did the bomb explode 0 = defused, 1 = exploded, 2 = paid 
		select 2:   how many secs will we wait until the next bomb-loop will be called
*/


IF (ISSERVER) THEN {
	_theobj 	= _this select 0;
	_handling 	= _this select 1;
	_sleepertt  = _this select 2;

	switch (_handling) do {
		case 0: {
			// If the bomb was defused succeed the task
			BR_Money_amount = BR_Money_amount + 2; 	
			["SUCCEEDED"] remoteExec ["BR_fnc_TaskState" , WEST , true];
		};
		case 1: {
			// If the bomb exploded, do a task fail
			[Whistle_Bomb] call BR_fnc_BombExplode; 
			["FAILED"] remoteExec ["BR_fnc_TaskState", WEST , true];
		};
		case 2: {
			// If the ransom money was paid, cancel the task
			["CANCELLED"] remoteExec ["BR_fnc_TaskState" , WEST , true];
		};
	};

	// Update the bankaccount for all clients
	publicvariable "BR_Money_amount";

	// Stop timer
	Whistle_INIT_TIMER = false;

	// Get list of enemies still in inArea
	_nearestUnits = _oldbombpos nearEntities ["Man", 250];
	_enemies = [];
	{
		_enemySides = [EAST, RESISTANCE];
		if (side _x in _enemySides) then {
			_enemies append [_x];
		};
	} forEach _nearestUnits;
	diag_log format ["#*# Bombrush #*# Enemies Array: %1",_enemies];

	// Delete the old bomb position marker
	deletevehicle Whistle_Bomb;
	deletemarker "bombpatrol";
	deletemarker "Bomb";
	deletemarker "Areamarker";
	deletemarker "Bombmrk";
	deletemarker "Centerpos";

	// Set END_TIME to 0 so we can reset it later
	END_TIME = 0;

	// If we paid the terrorist to stop the bomb, we have 500 seconds to regroup
	if (_sleepertt > 0) then {
		sleep _sleepertt;
	};

	// Create a new bomb
	[] spawn BR_fnc_MakeNewBomb;
	
	// Replace the enemies from the old site to the new bomb site
	[_enemies] spawn BR_fnc_EnemyReplacement;

} else {
	// Show player current bankroll
	[0,player] call BR_fnc_CheckBankaccount;

};