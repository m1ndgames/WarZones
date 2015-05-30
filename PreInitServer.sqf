if (!isServer) exitWith {};

// Give Tickets to the Teams
[blufor, 250] call BIS_fnc_respawnTickets;
[opfor, 250] call BIS_fnc_respawnTickets;
[resistance, 100] call BIS_fnc_respawnTickets;
["Server: Gave tickets to the Teams"] call WarZones_fnc_Debug;

// Start Ticket Bleeding for the Player Teams
[[blufor,opfor], 0.5, 3, 5] call BIS_fnc_bleedTickets;
["Server: Ticket Bleeding initialized"] call WarZones_fnc_Debug;

// Initialize Mission-End Check
[] spawn WarZones_fnc_CheckWin;

// Initialize dynamic groups - Server
["Initialize"] call BIS_fnc_dynamicGroups;
["Initialized Dynamic Groups"] call WarZones_fnc_Debug;