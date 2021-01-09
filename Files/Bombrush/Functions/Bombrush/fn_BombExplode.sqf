/*
	fn_bombExplode.sqf
	Written by: Whistleman
	For: Bombrush
	incoming params:
		select 0:	the current bomb
*/

_bomb = _this select 0;

/* Old way...
// Explosions in an array. Wow.
_shellarray = ["M_Mo_82mm_AT_LG", "Bo_GBU12_LGB", "HelicopterExploBig", "Bo_Mk82", "Bo_GBU12_LGB_MI10", "Bo_Mk82_MI08"];

// Select one of the explosions
_shell 	   = _shellarray select (floor(random (5)));

// Create the Boom.
_explosion = _shell createvehicle _bomb;
*/

_explosions = ["DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted","ClaymoreDirectionalMine_Remote_Ammo_Scripted"];
_choice = selectRandom _explosions;
_explosion = _choice createVehicle position _bomb;
_explosion setDamage 1;

// Remove actions from the bomb
{removeallactions _bomb} foreach playableunits;

// One exploded bomb closer to failed mission
[] call BR_fnc_DetonatedBombsAllowed;