// WarZones_Initialize_Server_PostInit.sqf
//
// Executes on Server after objects are initialized.
//
/////////////////////////////////////////////////////////////////////////////////////

// Initialize dynamic groups - Server
//["Initialize"] call BIS_fnc_dynamicGroups;
//["Initialized Dynamic Groups"] call WarZones_fnc_Debug;

// Create Side Centers and Groups
BLUFOR_HQ = createCenter blufor;
BLUFOR_Group = createGroup BLUFOR_HQ;
OPFOR_HQ = createCenter opfor;
OPFOR_Group = createGroup OPFOR_HQ;
INDEPENDENT_HQ = createCenter resistance;
INDEPENDENT_Group = createGroup INDEPENDENT_HQ;

// Give Tickets to the Teams
["add",blufor,250] call WarZones_fnc_Tickets;
["add",opfor,250] call WarZones_fnc_Tickets;
["add",resistance,100] call WarZones_fnc_Tickets;
["Gave tickets to the Teams"] call WarZones_fnc_Debug;

// Start Ticket Bleeding for the Player Teams
[[blufor,opfor], 0.5, 3, 5] call BIS_fnc_bleedTickets; ["Ticket Bleeding initialized"] call WarZones_fnc_Debug;

// Init Server Handlers
_serverhandlers = execVM "WarZones_Initialize_Server_Handlers.sqf";
waitUntil {isNull _serverhandlers};

// Function: Create Sectors
[] call WarZones_fnc_CreateSectors;

// Function: Loop > AiSpawn
[] call WarZones_fnc_LoopAiSpawn;

// Function: Loop > GearCheck
//[] call WarZones_fnc_LoopGearCheck;