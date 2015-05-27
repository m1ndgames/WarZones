if (!isServer) exitWith {};

// Initialize dynamic groups - Server
["Initialize"] call BIS_fnc_dynamicGroups;
["Initialized Dynamic Groups"] call WarZones_fnc_Debug;