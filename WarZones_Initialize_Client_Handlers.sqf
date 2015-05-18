// WarZones_Initialize_Client.sqf
/////////////////////////////////////////////////////////////////////////////////////
if (!isServer && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10};
};

// Enable HUD
showHUD true;

// Disable NPC Talk
player disableConversation true;

// Create Diary
[] call WarZones_fnc_CreateDiary;

_draw3dhandler = addMissionEventHandler ["Draw3D",{ [] call WarZones_fnc_draw3d; }];
["Client: Local Handler Created: Draw3D"] call WarZones_fnc_debug;

_drawmaphandler = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{ [] call WarZones_fnc_drawmap; }];
["Client: Local Handler Created: Draw"] call WarZones_fnc_debug;

player addEventHandler ["HandleDamage", {_this exec "WarZones_Handler_Player_HandleDamage.sqf"}];
["Friendly Fire: Disabled"] call WarZones_fnc_Debug;

execVM "scripts\3rdView.sqf";
["3rd Person View: Disabled"] call WarZones_fnc_Debug;

player enableFatigue false;
["Fatigue: Disabled"] call WarZones_fnc_Debug;


[] spawn {
		scopeName "GearCheck";
		while {true} do {
			[player] call WarZones_fnc_GearCheck;
		};
	sleep 5;
};


[] spawn {
	scopeName "SetRank";
	while {true} do {
		[] call WarZones_fnc_SetRank;
	};
	sleep 2;
};

[] call WarZones_fnc_DrawUI;