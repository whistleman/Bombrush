_state = _this select 0;
_task = player call BIS_fnc_taskCurrent;

[_task, _state, true] call BIS_fnc_taskSetState;