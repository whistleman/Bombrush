/*
 * Author: commy2
 * Draw the visible laser beams of all cached units.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ACE_laserpointer_fnc_onDraw
 *
 * Public: No
 */

// Only go off when sun is up. No red pointer when sun is down
if (count ACE3_LaserUnits > 0 && sunOrMoon > 0) then {
    _brightness = 2 - call ACE3_fnc_ambientBrightness;

    {
        if (_x isIRLaserOn currentWeapon _x) then {
            [_x, 100, false, _brightness] call ACE3_fnc_drawLaserPoint;
        };
    } forEach ACE3_LaserUnits;
};