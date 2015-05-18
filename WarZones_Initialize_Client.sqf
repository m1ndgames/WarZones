// WarZones_Initialize_Client.sqf
/////////////////////////////////////////////////////////////////////////////////////
if (!isServer && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10};
};

// Initialize dynamic groups - Client
//["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

