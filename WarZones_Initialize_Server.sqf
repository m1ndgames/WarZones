// WarZones_Initialize_Server_PostInit.sqf
//
// Executes on Server after objects are initialized.
//
/////////////////////////////////////////////////////////////////////////////////////
// Initialize dynamic groups - Server
//["Initialize"] call BIS_fnc_dynamicGroups;
//["Initialized Dynamic Groups"] call WarZones_fnc_Debug;

// Give Tickets to the Teams
["add",blufor,250] call WarZones_fnc_Tickets;
["add",opfor,250] call WarZones_fnc_Tickets;
["add",resistance,100] call WarZones_fnc_Tickets;
["Server: Gave tickets to the Teams"] call WarZones_fnc_Debug;

// Start Ticket Bleeding for the Player Teams
[[blufor,opfor], 0.5, 3, 5] call BIS_fnc_bleedTickets;
["Server: Ticket Bleeding initialized"] call WarZones_fnc_Debug;

// MP Handler: MPKilled
player addMPEventHandler ["MPKilled", {_this execVM "WarZones_hnd_MPKilled.sqf";}];
["Server: MP Handler Created: MPKilled"] call WarZones_fnc_Debug;

// MP Handler: MPHit
player addMPEventHandler ["MPHit", {_this execVM "WarZones_hnd_MPHit.sqf";}];
["Server: MP Handler Created: MPHit"] call WarZones_fnc_Debug;

// MP Handler: MPRespawn
player addMPEventHandler ["MPRespawn",{_this execVM "WarZones_hnd_MPRespawn.sqf";}];
["Server: MP Handler Created: MPRespawn"] call WarZones_fnc_Debug;

// Local Handler on Server > On Player Connect
onPlayerConnected "[_id, _uid, _name] execVM ""WarZones_hnd_PlayerConnected.sqf""";
["Server: Local Handler Created: OnPlayerConnected"] call WarZones_fnc_Debug;

// Local Handler on Server > On Player Disconnect
onPlayerDisconnected "[_id, _uid, _name] execVM ""WarZones_hnd_PlayerDisconnected.sqf""";
["Server: Local Handler Created: OnPlayerDisconnected"] call WarZones_fnc_Debug;

// Function: Create Sectors
[] call WarZones_fnc_CreateSectors;

// Function: Loop > AiSpawn
[] call WarZones_fnc_SpawnAi;

[] spawn {
	scopeName "SetRank";
	while {true} do {
		[] call WarZones_fnc_SetRank;
	};
	Sleep 30;
};
["Server: Spawned Loop: SetRank"] call WarZones_fnc_debug;

// Initialize Mission-End Check
[] spawn WarZones_fnc_CheckWin;

// End Server Init