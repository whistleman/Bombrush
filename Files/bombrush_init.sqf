//////////////////////////////////////////////////////////////////////////////////////////////
//
// Whistle's Bombrush
// Version 1.1.2
//
//////////////////////////////////////////////////////////////////////////////////////////////

task2 = player createsimpletask ["Kill the leader"];
task2 setsimpletaskdescription ["The leader which is ordering to plant the bombs is somewhere on the Island. Kill him.", "Kill the leader", ""];

player createDiarySubject ["Bombrush", "Bombrush"];
player createDiaryRecord ["Bombrush", ["Credits", "Credits to Spliffz, <br />FAROOQ, <br />EGG_EVO, <br />T-800a, <br />Tajin, <br />Kronzky, <br />Zorilya, <br />Killzone Kid, <br />D4nny (tester), <br />Spectre (tester) <br /><br />Have fun Playing bombrush!<br />Greetings, Whistle"]];
player createDiaryRecord ["Diary", ["Hints", "A few days ago a large shipment of suitcases, bags and other luggage have been gone missing."]];
player createDiaryRecord ["Diary", ["Hints", "The more enemy units you leave on the map, the less time you have before the next bomb goes off."]];
player createDiaryRecord ["Diary", ["Logistics", "There are three Hunters, two Hummingbirds, a UH-80 Ghost Hawk and a MQ4A Greyhawk at your disposal. Use them wisely."]];
player createDiaryRecord ["Diary", ["Situation", "Terorrists have been hiding on Altis for quite some time now. They are planning an attack of some kind, but we do not know when are what they have planned. Just when you arrive back at base, your phone rings..."]];

call compile preprocessFileLineNumbers "Files\Bombrush\functions.sqf";
call compile preprocessFileLineNumbers "Files\AI\spliffz_terroristCreator.sqf";

// Pre-recuisit for Spliffz_terroristcreator
Resistance setFriend [East, 1];
East setFriend [Resistance, 1];

// call vehicle serviceing script
_cthread = [] execVM "Files\Veh.Respawn\vehicle_service.sqf";


fnc_Whistle_enablesimulation = {_this select 0 enablesimulation true;}; // _this select 0 al geprobeerd leverde generic error op...

{_x addMPEventHandler ["MPRespawn", {fnc_Whistle_enablesimulation}];} foreach playableunits;

if (isServer) then {
WIS_config_exp			= (configfile >> "CfgVehicles") call Bis_fnc_getCfgSubClasses;
WIS_array_defusers 		= ["B_engineer_F", "B_Story_Engineer_F", "B_G_engineer_F", "B_CTRG_soldier_engineer_exp_F", "B_soldier_exp_F", "B_diver_exp_F", "B_G_Soldier_exp_F", "NLD_NFPG_EXPL", "NLD_NFPG_ENGI"];
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

call compileFinal preprocessFileLineNumbers "Files\Bombrush\createcamps.sqf";

Whislte_INT_JIP = {
END_TIME = END_TIME;
ELAPSED_TIME = ELAPSED_TIME;
Whistle_Areamarker = Whistle_Areamarker;
Whistle_Money_amount = Whistle_Money_amount;
Whistle_centerpos = Whistle_centerpos;
[PLAYER] call WIS_fnc_createtask;
};

["BIS_id", "onPlayerConnected", "Whislte_INT_JIP"] call BIS_fnc_addStackedEventHandler;