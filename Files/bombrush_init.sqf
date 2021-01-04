//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
//
//////////////////////////////////////////////////////////////////////////////////////////////

// Create the task for killing the terrorist leader
_taskName = "Kill the terrorist leader";
_taskDesc = "The leader which is ordering to plant the bombs is somewhere on the Island. Kill him.";
[WEST, [_taskName], [_taskDesc, _taskName, _taskName], objNull, "CREATED", -1, true, "kill", false] call BIS_fnc_taskCreate;

// Create the description of bombrush in the briefing
player createDiarySubject ["Bombrush", "Bombrush"];
player createDiaryRecord ["Bombrush", ["Credits", "Credits to Spliffz, <br />FAROOQ, <br />EGG_EVO, <br />T-800a, <br />Tajin, <br />Kronzky, <br />Zorilya, <br />Killzone Kid, <br />D4nny (tester), <br />Spectre (tester) <br /><br />Have fun Playing bombrush!<br />Greetings, Whistle"]];
player createDiaryRecord ["Diary", ["Hints", "A few days ago a large shipment of suitcases, bags and other luggage have been gone missing."]];
player createDiaryRecord ["Diary", ["Hints", "The more enemy units you leave on the map, the less time you have before the next bomb goes off."]];
player createDiaryRecord ["Diary", ["Logistics", "There are three Hunters, two Hummingbirds, a UH-80 Ghost Hawk and a MQ4A Greyhawk at your disposal. Use them wisely."]];
player createDiaryRecord ["Diary", ["Situation", "Terorrists have been hiding on Altis for quite some time now. They are planning an attack of some kind, but we do not know when are what they have planned. Just when you arrive back at base, your phone rings..."]];

// call compileFinal preprocessFileLineNumbers "Files\Bombrush\functions.sqf";
call compileFinal preprocessFileLineNumbers "Files\AI\spliffz_terroristCreator.sqf";

// Pre-recuisit for Spliffz_terroristcreator
Resistance setFriend [East, 1];
East setFriend [Resistance, 1];

// call vehicle serviceing script
_cthread = [] execVM "Files\Veh.Respawn\vehicle_service.sqf";

// When you die while defusing the bomb enablesimulation should be turned on again
{_x addMPEventHandler ["MPRespawn", {_this select 0 enablesimulation true}];} foreach playableunits;

// Only engineers can defuse the bomb
if (isServer) then {
	WIS_config_exp			= (configfile >> "CfgVehicles") call Bis_fnc_getCfgSubClasses;
	WIS_array_defusers 		= ["B_engineer_F", "B_Story_Engineer_F", "B_G_engineer_F", "B_CTRG_soldier_engineer_exp_F", "B_soldier_exp_F", "B_diver_exp_F", "B_G_Soldier_exp_F"];
	WIS_param_defuse		= paramsarray select 11;

	IF (WIS_param_defuse == 1) then {
		{
			_found = ["exp", _x] call KK_fnc_inString;
			IF (_found) then {WIS_array_defusers set [count WIS_array_defusers, _x];};
		} foreach WIS_config_exp;
	} else {
		WIS_array_defusers = WIS_config_exp;
	};

	publicvariable "WIS_array_defusers";
};

// Initialize the script that creates the terrorist camp
call compileFinal preprocessFileLineNumbers "Files\Bombrush\createcamps.sqf";

// When JIP, make sure all variables are loaded as well
["BIS_id", "onPlayerConnected", "BR_fnc_InitJIP"] call BIS_fnc_addStackedEventHandler;