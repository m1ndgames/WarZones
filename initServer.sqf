// WarZones_Initialize_Server_PostInit.sqf
//
// Executes on Server after objects are initialized.
//
/////////////////////////////////////////////////////////////////////////////////////
// Function: Create Sectors
[] call WarZones_fnc_CreateSectors;

// Function: Loop > AiSpawn
// [] spawn WarZones_fnc_SpawnAi;

// End Server Init