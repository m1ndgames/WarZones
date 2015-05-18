/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_Gear.sqf
/  Description: Adds loadouts according to Rank
/
*/

// Register Gear Templates according to player rank
if (Rank player == "PRIVATE") then {
	// Set Shoulder Patch according to Rank
	[player,"Private"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[player,"Rifleman"] call BIS_fnc_addRespawnInventory;
	[player,"Grenadier"] call BIS_fnc_addRespawnInventory;
	[player,"Medic"] call BIS_fnc_addRespawnInventory;
	[player,"Autorifleman"] call BIS_fnc_addRespawnInventory;
	[player,"ATSoldier"] call BIS_fnc_addRespawnInventory;
	[player,"AASoldier"] call BIS_fnc_addRespawnInventory;
	[player,"Sapper"] call BIS_fnc_addRespawnInventory;
	[player,"Sniper"] call BIS_fnc_addRespawnInventory;
	[player,"Marksmen"] call BIS_fnc_addRespawnInventory;
	[player,"Recon"] call BIS_fnc_addRespawnInventory;
	[player,"Pilot"] call BIS_fnc_addRespawnInventory;
	[player,"Crewman"] call BIS_fnc_addRespawnInventory;
};

if (Rank player == "CORPORAL") then {
	// Set Shoulder Patch according to Rank
	[player,"Corporal"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[player,"Grenadier"] call BIS_fnc_addRespawnInventory;
	[player,"Medic"] call BIS_fnc_addRespawnInventory;
};

if (Rank player == "SERGEANT") then {
	// Set Shoulder Patch according to Rank
	[player,"Sergeant"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[player,"Autorifleman"] call BIS_fnc_addRespawnInventory;
	[player,"ATSoldier"] call BIS_fnc_addRespawnInventory;
	[player,"AASoldier"] call BIS_fnc_addRespawnInventory;
};

if (Rank player == "LIEUTENANT") then {
	// Set Shoulder Patch according to Rank
	[player,"Lieutenant"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[player,"Sapper"] call BIS_fnc_addRespawnInventory;
	[player,"Sniper"] call BIS_fnc_addRespawnInventory;
};

if (Rank player == "CAPTAIN") then {
	// Set Shoulder Patch according to Rank
	[player,"Captain"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[player,"Marksmen"] call BIS_fnc_addRespawnInventory;
	[player,"Recon"] call BIS_fnc_addRespawnInventory;
};

if (Rank player == "MAJOR") then {
	// Set Shoulder Patch according to Rank
	[player,"Major"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[player,"Pilot"] call BIS_fnc_addRespawnInventory;
	[player,"Crewman"] call BIS_fnc_addRespawnInventory;
};

if (Rank player == "COLONEL") then {
	// Set Shoulder Patch according to Rank
	[player,"Colonel"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
};

if (Rank player == "GENERAL") then {
	// Set Shoulder Patch according to Rank
	[player,"General"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
};