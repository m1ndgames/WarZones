/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: init.sqf
/  Description: This init script is executed when mission is started (before briefing screen)
/
*/

//run on dedicated server only
if (isDedicated) then {

};


//run on dedicated server or player host
if (isServer) then {
	// Init Server
	_server = execVM "WarZones_Initialize_Server.sqf";
	waitUntil {isNull _server};

	// Pilots array
	pilots = [];
	tankcrew = [];

	// Init Client Handlers
	["WarZones_Initialize_Client_Handlers.sqf","BIS_fnc_execVM",true,true ] call BIS_fnc_MP;
};

//run on all player clients incl. player host
if (hasInterface) then {
	waitUntil {(getPlayerUID player) != "" && !isNull player && isPlayer player};

	// Init Client
	_client = execVM "WarZones_Initialize_Client.sqf";
	waitUntil {isNull _client};
};

//run on all player clients incl. player host and headless clients
if (!isDedicated) then {

};

//run on all player clients incl. headless clients but not player host
if (!isServer) then {

};

//run on headless clients and dedicated server
if (!hasInterface) then {

};

//run on headless clients only
if (!hasInterface && !isDedicated) then {

};