/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_Gear.sqf
/  Description: Adds loadouts according to Rank
/
*/
if (!isServer) exitWith {};

_playerobject = _this select 0;
_playeruid = _this select 1;
_playerscore = [_playeruid, "score", 7501] call stats_get;

// Set Rank according to Score
[format ["Performing Rank Check for %1 (UID %2)- Score: %3", name _playerobject, _playeruid, _playerscore]] call WarZones_fnc_Debug;

if (_playerscore < 500) then {
	_playerobject setUnitRank "PRIVATE";
};

if (_playerscore > 500) then {
	if (_playerscore < 1500) then {
		_playerobject setUnitRank "CORPORAL";
	};
};

if (_playerscore > 1500) then {
	if (_playerscore < 2500) then {
		_playerobject setUnitRank "SERGEANT";
	};
};

if (_playerscore > 2500) then {
	if (_playerscore < 3500) then {
		_playerobject setUnitRank "LIEUTENANT";
	};
};

if (_playerscore > 3500) then {
	if (_playerscore < 5000) then {
		_playerobject setUnitRank "CAPTAIN";
	};
};

if (_playerscore > 5000) then {
	if (_playerscore < 7500) then {
		_playerobject setUnitRank "MAJOR";
	};
};

if (_playerscore > 7500) then {
	_playerobject setUnitRank "COLONEL";
};



[format ["Performing Gear Check for %1 - Rank: %2 - Score: %3", name _playerobject, Rank _playerobject, _playerscore]] call WarZones_fnc_Debug;

// Register Gear Templates according to player rank
if (Rank _playerobject == "PRIVATE") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Private"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Rifleman"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "CORPORAL") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Corporal"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Rifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Grenadier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Medic"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "SERGEANT") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Sergeant"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Rifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Grenadier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Medic"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Autorifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"ATSoldier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"AASoldier"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "LIEUTENANT") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Lieutenant"] call BIS_fnc_setUnitInsignia;

	// Set Loadout according to Rank
	[_playerobject,"Rifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Grenadier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Medic"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Autorifleman"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"ATSoldier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"AASoldier"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Sapper"] call BIS_fnc_addRespawnInventory;
	[_playerobject,"Sniper"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "CAPTAIN") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Captain"] call BIS_fnc_setUnitInsignia;

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
};

if (Rank _playerobject == "MAJOR") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Major"] call BIS_fnc_setUnitInsignia;

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
	[_playerobject,"Doctor"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "COLONEL") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"Colonel"] call BIS_fnc_setUnitInsignia;

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
	[_playerobject,"Doctor"] call BIS_fnc_addRespawnInventory;
};

if (Rank _playerobject == "GENERAL") then {
	// Set Shoulder Patch according to Rank
	[_playerobject,"General"] call BIS_fnc_setUnitInsignia;

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
	[_playerobject,"Doctor"] call BIS_fnc_addRespawnInventory;
};