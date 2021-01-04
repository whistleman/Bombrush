_shellarray = ["M_Mo_82mm_AT_LG", "Bo_GBU12_LGB", "HelicopterExploBig", "Bo_Mk82", "Bo_GBU12_LGB_MI10", "Bo_Mk82_MI08"];
_shell 	   = _shellarray select (floor(random (5)));
_explosion = _shell createvehicle position (_this select 0);
{removeallactions _x} foreach playableunits;
[] call BR_fnc_DetonatedBombsAllowed;
