// When the bomb is hit by a bullet, explode
_this addeventhandler ["HitPart", {[_this select 0, 1, 30] remoteExec ["BR_fnc_DeleteAll", 0, true];}];

// Add action to defuse the bomb
_this addAction ["Defuse bomb", "Files\Bombrush\Defuse.sqf"];