// WarZones_Initialize_Server_PostInit.sqf
//
// Executes on Server after objects are initialized.
//
/////////////////////////////////////////////////////////////////////////////////////

// Give Tickets to the Teams
[blufor, 250] call BIS_fnc_respawnTickets;
[opfor, 250] call BIS_fnc_respawnTickets;
[resistance, 100] call BIS_fnc_respawnTickets;
["Server: Gave tickets to the Teams"] call WarZones_fnc_Debug;

// Start Ticket Bleeding for the Player Teams
[[blufor,opfor], 0.5, 3, 5] call BIS_fnc_bleedTickets;
["Server: Ticket Bleeding initialized"] call WarZones_fnc_Debug;

// Function: Create Sectors
[] call WarZones_fnc_CreateSectors;

// Function: Loop > AiSpawn
[] call WarZones_fnc_SpawnAi;

// Initialize Mission-End Check
[] spawn WarZones_fnc_CheckWin;

{
	_x addEventHandler ["Killed",
	{
		_victim = _this select 0;
		_killer = _this select 1;
		_killeruid = getPlayerUID _killer;

		if (!isPlayer _killer) exitWith {};
		if (_killeruid == "") exitWith {};

		_killerscore = [_killeruid, "score", 1] call stats_get;
		_killerscore = _killerscore + 10;
		[_killeruid, "score", _killerscore] call stats_set;
		[format ["%1 was killed by UID %2 - Player score: %3", _victim, _killeruid, _killerscore]] call WarZones_fnc_Debug;
		["Kill: +10 Pts.","hintSilent", _killer,true,true] call BIS_fnc_MP;
	}];
} forEach playableUnits;

// End Server Init