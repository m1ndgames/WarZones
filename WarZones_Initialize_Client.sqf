// WarZones_Initialize_Client.sqf
/////////////////////////////////////////////////////////////////////////////////////
if (!isServer && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10};
	waitUntil {(getPlayerUID player) != "" && !isNull player && isPlayer player};
};

// Initialize dynamic groups - Client
//["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

