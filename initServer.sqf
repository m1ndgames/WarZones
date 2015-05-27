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

// End Server Init