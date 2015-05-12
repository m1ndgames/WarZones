/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_Gear.sqf
/  Description: Adds loadouts according to Rank
/
*/

_playerobject = _this select 0;

// Register Gear Templates according to player rank
if (Rank _playerobject == "PRIVATE") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Private"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Rifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Grenadier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Medic"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Autorifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"ATSoldier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"AASoldier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Sapper"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Sniper"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Marksmen"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Recon"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Pilot"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Crewman"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "CORPORAL") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Corporal"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Grenadier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Medic"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "SERGEANT") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Sergeant"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Autorifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"ATSoldier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"AASoldier"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "LIEUTENANT") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Lieutenant"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Sapper"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Sniper"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "CAPTAIN") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Captain"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Marksmen"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Recon"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "MAJOR") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Major"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Pilot"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Crewman"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "COLONEL") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Colonel"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
};

if (Rank _playerobject == "GENERAL") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"General"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
};