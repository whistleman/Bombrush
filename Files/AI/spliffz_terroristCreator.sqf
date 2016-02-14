/**
  *	Spliffz Terrorist/Insurgent Creator Script v1.02
  * Creates a terrorist/insurgent.
  *
  *	Kavala CQB Version
  *
  * This creates a group with Terrorists consisting out of Opfor and Independent units
  * wearing 'terrorist like' clothes and a shemag.
  * I even geared them appropriately with Massi's NATO pack, cuz a real terrorist packs an AK.
  *
  *
  * Mission requirements:
  * Editor: set Independent friendly to Opfor. Or else you will get civil war between your local terrorists.
  * or Script: Resistance setFriend [East, 1]; East setFriend [Resistance, 1];
  *
  *
  * params: 
  * markername - required
  * # units (optional) - 0 = random 8 (default)
  * skill - 1-10, 100 = random. (optional, default 0.2)
  * car - 1,0 (optional, default 0)
  *
  *
  * usage: 
  *	in init.sqf: compile preprocessFileLineNumbers "spliffz_terroristCreator.sqf";
  * call with: _terroristGrp = [spawnmarker, 0, 2, 1] call spliffz_createTerrorist;
  *
  *
  * return:
  *	Group of terrorists
  *
  *
  *	OPTIONAL MODS:
  *	 - NATO SF and RUSSIAN SPETSNAZ WEAPONS for A3 v1.0
  *  - 
  *
  * Arma 3 DEV 1.05.xxxx - Spliffz <thespliffz@gmail.com>
**/

/**
  * CHANGELOG
  *
  * [1.03]
  *  - added AT terrorists
  * [1.02]
  *  - added cars/technical parameter
  *	 - added skill parameter
  * [1.01]
  *  - added PKM & SVD
  *  - made it spawn a group, instead of just 1 terrorist per call
  *	[1.0]
  *  - Made the Terrorist Creator.
  *
**/

///////////////////////////
//
//"1Rnd_HE_Grenade_shell", "30Rnd_556x45_Stanag_Tracer_Green", "150Rnd_762x51_Box_Tracer"
//
//_mass = isClass (configFile >> "CfgPatches" >> "mas_weapons");
//if(_mass) then {
//	spliffz_terror_weapons = ["arifle_mas_aks74_a","LMG_mas_rpk_F","arifle_mas_akms","arifle_mas_akm","LMG_mas_pkm_F","srifle_mas_svd_l"];
//	spliffz_terror_launchers = ["launch_RPG32_F","launch_mas_RPG32AA_F"];
//} else {
//	spliffz_terror_weapons = ["arifle_Mk20C_F","arifle_Mk20_GL_F","LMG_Zafir_F"]; 
//	spliffz_terror_launchers = ["launch_RPG32_F"];
//};
//
///////////////////////////
if (isNil "Whistle_terrorist_money_amount") then {
	_mass = isClass (configFile >> "CfgPatches" >> "mas_weapons");
	if(_mass) then {
			spliffz_terror_weapons = ["arifle_mas_aks74_a","LMG_mas_rpk_F","arifle_mas_akms","arifle_mas_akm"];
			//spliffz_terror_launchers = ["launch_RPG32_F","launch_mas_RPG32AA_F"];
		} else {
			spliffz_terror_weapons = ["arifle_Mk20C_F"];
			//spliffz_terror_launchers = ["launch_RPG32_F"];

		// Defines when terrorists are not paid
		spliffz_terror_units_array = ["O_soldier_F"]; // TOOK OUT "I_soldier_F", 
		spliffz_terror_uniforms_opfor = ["U_OG_leader","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2"];
		spliffz_terror_uniforms_ind = ["U_IG_leader","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2"];
		spliffz_terror_vests = ["V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr"]; //took out ,"V_PlateCarrierIA1_dgtl","V_PlateCarrier1_rgr"
		spliffz_terror_headgear = ["H_Shemag_khk","H_Shemag_tan"];
		spliffz_terror_backpacks = ["B_Bergen_rgr","B_Bergen_sgg"];
		//spliffz_terror_wpnAttachments = ["acc_pointer_IR","optic_ACO_grn"]; 
		spliffz_terror_wpnAttachments = ["acc_flashlight"]; // took out ,"optic_ACO_grn"
		spliffz_terror_items = ["FirstAidKit"];
		spliffz_terror_assigned_items = ["ItemMap","ItemCompass","ItemWatch","ItemRadio"];
		spliffz_terror_ammo_grenades = ["SmokeShell"];
		spliffz_terror_vehicles_cars = ["B_G_Offroad_01_F"];

		};
	} else {
	if (Whistle_terrorist_money_amount >= 10) then { 

	_mass = isClass (configFile >> "CfgPatches" >> "mas_weapons");
		if(_mass) then {
			spliffz_terror_weapons = ["arifle_mas_aks74_a","LMG_mas_rpk_F","arifle_mas_akms","arifle_mas_akm","LMG_mas_pkm_F","srifle_mas_svd_l"];
			spliffz_terror_launchers = ["launch_RPG32_F","launch_mas_RPG32AA_F"];
		} else {
			spliffz_terror_weapons = ["arifle_Mk20C_F","arifle_Mk20_GL_F","LMG_Zafir_F"]; 
			spliffz_terror_launchers = ["launch_RPG32_F"];

		// Defines when terrorists are paid
		spliffz_terror_units_array = ["O_soldier_F"]; // TOOK OUT "I_soldier_F", 
		spliffz_terror_uniforms_opfor = ["U_OG_leader","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2"];
		spliffz_terror_uniforms_ind = ["U_IG_leader","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2"];
		spliffz_terror_vests = ["V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_PlateCarrierIA1_dgtl","V_PlateCarrier1_rgr"];
		spliffz_terror_headgear = ["H_Shemag_khk","H_Shemag_tan"];
		spliffz_terror_backpacks = ["B_Bergen_rgr","B_Bergen_sgg"];
		//spliffz_terror_wpnAttachments = ["acc_pointer_IR","optic_ACO_grn"]; 
		spliffz_terror_wpnAttachments = ["acc_flashlight", "optic_ACO_grn"];
		spliffz_terror_items = ["FirstAidKit"];
		spliffz_terror_assigned_items = ["ItemMap","ItemCompass","ItemWatch","ItemRadio"];
		spliffz_terror_ammo_grenades = ["HandGrenade","HandGrenade","SmokeShell","SmokeShell"];
		spliffz_terror_vehicles_cars = ["B_G_Offroad_01_armed_F"];

		};
	} else {

	_mass = isClass (configFile >> "CfgPatches" >> "mas_weapons");
	if(_mass) then {
			spliffz_terror_weapons = ["arifle_mas_aks74_a","LMG_mas_rpk_F","arifle_mas_akms","arifle_mas_akm"];
			//spliffz_terror_launchers = ["launch_RPG32_F","launch_mas_RPG32AA_F"];
		} else {
			spliffz_terror_weapons = ["arifle_Mk20C_F"];
			//spliffz_terror_launchers = ["launch_RPG32_F"];

		// Defines when terrorists are not paid
		spliffz_terror_units_array = ["O_soldier_F"]; // TOOK OUT "I_soldier_F", 
		spliffz_terror_uniforms_opfor = ["U_OG_leader","U_OG_Guerilla1_1","U_OG_Guerilla2_1","U_OG_Guerilla2_2","U_OG_Guerilla2_3","U_OG_Guerilla3_1","U_OG_Guerilla3_2"];
		spliffz_terror_uniforms_ind = ["U_IG_leader","U_IG_Guerilla1_1","U_IG_Guerilla2_1","U_IG_Guerilla2_2","U_IG_Guerilla2_3","U_IG_Guerilla3_1","U_IG_Guerilla3_2"];
		spliffz_terror_vests = ["V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr"]; //took out ,"V_PlateCarrierIA1_dgtl","V_PlateCarrier1_rgr"
		spliffz_terror_headgear = ["H_Shemag_khk","H_Shemag_tan"];
		spliffz_terror_backpacks = ["B_Bergen_rgr","B_Bergen_sgg"];
		//spliffz_terror_wpnAttachments = ["acc_pointer_IR","optic_ACO_grn"]; 
		spliffz_terror_wpnAttachments = ["acc_flashlight"]; // took out ,"optic_ACO_grn"
		spliffz_terror_items = ["FirstAidKit"];
		spliffz_terror_assigned_items = ["ItemMap","ItemCompass","ItemWatch","ItemRadio"];
		spliffz_terror_ammo_grenades = ["SmokeShell"];
		spliffz_terror_vehicles_cars = ["B_G_Offroad_01_F"];

		};
	};
};


/*------------ Here start the functions -------------*/

/*
 * Gears the terrorist unit
 * params: terrorist-unit 
 * [_terrorist] call spliffz_terror_gear_unit;
 * return: the terrorist unit
*/
spliffz_terror_gear_unit = {
	private ["_group", "_unit", "_uniform", "_vest", "_headgear", "_goggles", "_weapon", "_mag", "_backpack", "_backpackItems", "_wpnAttachments", "_pistolAttachments", "_items", "_assItems", "_secWpnAttachments"];

	_group = _this select 0; 
	{
		diag_log format ["Gear unit"];
		//_unit = _this select 0;
		_unit = _x;
		diag_log format ["Unit: %1", _x];
		
		// remove all stuff
		removeAllWeapons _unit;
		removeAllItems _unit;
		removeAllAssignedItems _unit;
		removeAllHandgunItems _unit;
		removeAllItemsWithMagazines _unit;
		removeGoggles _unit;
		removeHeadgear _unit;
		removeVest _unit;
		removeUniform _unit;
		removeBackpack _unit;

		// get the gear
		_uniform = spliffz_terror_uniforms_opfor call BIS_fnc_selectRandom;
		_vest = spliffz_terror_vests call BIS_fnc_selectRandom;
		_headgear = spliffz_terror_headgear call BIS_fnc_selectRandom;
		_goggles = "";
		_backpack = "";
		_backpackItems = "";
		_launcher = "";
		_uniformItems = "";
		_vestItems = "";
		
		// weapongambling...
		_weapon = spliffz_terror_weapons call BIS_fnc_selectRandom;
		if(["aks74", _weapon] call BIS_fnc_inString) then {
			_mag = "30Rnd_mas_545x39_T_mag";
		};
		if(["akms", _weapon] call BIS_fnc_inString || ["akm", _weapon] call BIS_fnc_inString) then {
			_mag = "30Rnd_mas_762x39_T_mag";
		};
		if(["rpk", _weapon] call BIS_fnc_inString) then {
			_mag = "100Rnd_mas_545x39_T_mag";
		};
		if(["pkm", _weapon] call BIS_fnc_inString) then {
			_mag = "100Rnd_mas_762x54_T_mag";
		};
		if(["svd_", _weapon] call BIS_fnc_inString) then {
			_mag = "10Rnd_mas_762x54_T_mag";
		};
		// vanilla stuff
		if(["Mk20", _weapon] call BIS_fnc_inString) then {
			_mag = "30Rnd_556x45_Stanag_Tracer_Green";
		}; 
		if(["Zafir", _weapon] call BIS_fnc_inString) then {
			_mag = "150Rnd_762x51_Box_Tracer";
		}; 
		
		// AT?
		_at = 0;
		if (!isNil "spliffz_terror_launchers") then {
		    if(random(1) > 0.8 && _at < 1) then {
			_launcher = spliffz_terror_launchers call BIS_fnc_selectRandom;
			diag_log format ["Launcher: %1", _launcher];
			if(["RPG32AA", _launcher] call BIS_fnc_inString) then {
				//_atmag = "RPG32_mas_AA_F";
				_backpackItems = ["RPG32_mas_AA_F", "RPG32_mas_AA_F"];
			} else {
				//_atmag = "RPG32_HE_F";
				_backpackItems = ["RPG32_HE_F","RPG32_HE_F"];
			};
			_backpack = spliffz_terror_backpacks call BIS_fnc_selectRandom;
			/*
			_backpackItems = [];
			{
				_backpackItems set [count _backpackItems, _atmag];
			} foreach [1,2];
			diag_log format ["backpackItems: %1", str _backpackItems];
			*/
			_at = 1;
                     };
		};
		
		/*
		if(random(1) > 0.5) then {
			_wpnAttachments = spliffz_terror_wpnAttachments call BIS_fnc_selectRandom;
		} else {
			if(random(1) > 0.5) then {
				_wpnAttachments = spliffz_terror_wpnAttachments;
			} else {
				_wpnAttachments = "";
			};
		};
		*/
		_wpnAttachments = spliffz_terror_wpnAttachments;
		_pistolAttachments = "";
		_items = spliffz_terror_items;
		_assItems = spliffz_terror_assigned_items;
		_secWpnAttachments = "";
		

		// apply it
		_unit addUniform _uniform;
		if(typename _uniformItems == typename []) then {
			{ _unit addItemToUniform _x; } forEach _uniformItems;
		};
		_unit addVest _vest;
		if(typename _vestItems == typename []) then {
			{ _unit addItemToVest _x; } forEach _vestItems;
		};
		_unit addHeadgear _headgear;
		_unit addGoggles _goggles;
		if(_backpack != "") then {
			_unit addBackpack _backpack;
		};
		if(typename _backpackItems == typename []) then {
		// need to filter shit out
			//{ _unit addItemToBackpack _x; } forEach _backpackItems;
			{ _unit addMagazine _x; } forEach _backpackItems;
		};
		if(_launcher != "") then {
			_unit addWeapon _launcher;
		};
		_unit addWeapon _weapon;
		{ _unit addMagazine _mag; } foreach [1,2,3,4,5,6];
		{ _unit addItem _x; } foreach spliffz_terror_ammo_grenades;
		if(typename _wpnAttachments == typename []) then {
			{ _unit addPrimaryWeaponItem _x; } forEach _wpnAttachments;
		} else {
			_unit addPrimaryWeaponItem _wpnAttachments;
		};
		if(typename _pistolAttachments == typename []) then {
			{ _unit addHandgunItem _x; } forEach _pistolAttachments;
		};
		{ _unit addItem _x; } forEach spliffz_terror_items;
		{ _unit addItem _x; } forEach spliffz_terror_assigned_items;
		{ _unit assignItem _x; } forEach spliffz_terror_assigned_items;
		if(typename _secWpnAttachments == typename []) then {
			{ _unit addSecondaryWeaponItem _x; } forEach _secWpnAttachments;
		};
		
	} foreach units _group;
};



/*
 * Creates the terrorist unit
 * params: # units (optional) - 0 = random 8
 * 
 * usage:
 * [5] call spliffz_createTerrorist;
 * return: the terrorist group
*/
spliffz_createTerrorist = {
	private ["_unit", "_uniform", "_vest", "_headgear", "_terrorist", "_HQ", "_grp", "_spmrk", "_n", "_c", "_vic", "_car", "_s", "_wp"];
	
	_spmrk = _this select 0;
	_n = if((_this select 1) > 0) then { _this select 1; } else { random(8) };
	//diag_log format ["number: %1", _n];
	_s = if((_this select 2) < 11) then { (_this select 2)/10; } else { if((_this select 2) == 100) then { round(random(10))/10; } else { 0.2; }; };
	//diag_log format ["skill: %1", _s];
	_c = if((_this select 3) > 0) then { _this select 3; } else { 0; };
	diag_log format ["Cars?: %1", _c];
	
	_unit = spliffz_terror_units_array call BIS_fnc_selectRandom;
	_isOpfor = ["O_soldier_", _unit] call BIS_fnc_inString;

	if(_isOpfor) then {
		// opfor
		_HQ = createCenter east;
		_grp = createGroup east;
		
		// create unit
		for "_x" from 1 to _n do {
			//_terrorist = _unit createUnit [getPos player, _opforGrp];
			_terrorist = _unit createUnit [getMarkerPos _spmrk, _grp];
			//diag_log format ["opfor unit"];
		};
		
		[_grp] call spliffz_terror_gear_unit;

		if(_c > 0) then {
			_car = spliffz_terror_vehicles_cars call BIS_fnc_selectRandom;
			//diag_log format ["CAR: %1", _car];
			_vic = _car createVehicle [(getMarkerPos _spmrk select 0), (getMarkerPos _spmrk select 1)+5, 0];
			//diag_log format ["MARKERPOS: %1, %2", (getMarkerPos _spmrk select 0), (getMarkerPos _spmrk select 1)+5];

			// make squad enter vehicle
			_grp addVehicle _vic;
			_wp = _grp addWaypoint [position _vic, 0];
			_wp setWaypointType "GETIN";
		};

		// return
		_grp
		
	} else {
		// ind
		_HQ = createCenter resistance;
		_grp = createGroup resistance;

		for "_x" from 1 to _n do {
			//_terrorist = _unit createUnit [getPos player, _indGrp];
			_terrorist = _unit createUnit [getMarkerPos _spmrk, _grp];
			//diag_log format ["ind unit"];
		};

		[_grp] call spliffz_terror_gear_unit;

		if(_c > 0) then {
			_car = spliffz_terror_vehicles_cars call BIS_fnc_selectRandom;
			//diag_log format ["CAR: %1", _car];
			_vic = _car createVehicle [(getMarkerPos _spmrk select 0), (getMarkerPos _spmrk select 1)+5, 0];
			//diag_log format ["MARKERPOS: %1, %2", (getMarkerPos _spmrk select 0), (getMarkerPos _spmrk select 1)+5];

			// make squad enter vehicle
			_grp addVehicle _vic;
			_wp = _grp addWaypoint [position _vic, 0];
			_wp setWaypointType "GETIN";
		};
		
		// return
		_grp
	};

};

/*-------------- Here start the code ---------------*/

//_mySpawnMarker = "spawnMark";

//_terroristGrp = [_mySpawnMarker, 0, 2, 1] call spliffz_createTerrorist;
// [spawnmarker, 0, 2, 1]
// marker, units, skill (0-10, 100=random), car


// EOF