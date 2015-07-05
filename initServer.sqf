<<<<<<< HEAD
/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: initServer.sqf
/  Description: This init script is executed by server when the mission is started. (Before briefing screen)
/
*/
if (!isServer) exitWith {};

// End of File: InitServer.sqf
=======
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
>>>>>>> de1852e4847c0b8b5bdc03dc95b643e36d753808
