// WarZones_Initialize_Client.sqf
/////////////////////////////////////////////////////////////////////////////////////
if (player != player) then {
	waitUntil {player == player};
};

["Client: Initializing..."] call WarZones_fnc_debug;

[player] call WarZones_fnc_CheckGear;

// Enable HUD
showHUD true;
["Client: HUD enabled"] call WarZones_fnc_debug;

// Disable NPC Talk
player disableConversation true;
["Client: Disabled conversations"] call WarZones_fnc_debug;

execVM "scripts\3rdView.sqf";
["Client: 3rd Person View: Disabled"] call WarZones_fnc_Debug;

player enableFatigue false;
["Client: Fatigue: Disabled"] call WarZones_fnc_Debug;

// Create Diary
[] spawn WarZones_fnc_CreateDiary;
["Client: Diary created"] call WarZones_fnc_debug;

_draw3dhandler = addMissionEventHandler ["Draw3D",{ [] call WarZones_fnc_draw3d; }];
["Client: Local Handler Created: Draw3D"] call WarZones_fnc_debug;

_drawmaphandler = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{ [] call WarZones_fnc_drawmap; }];
["Client: Local Handler Created: Draw"] call WarZones_fnc_debug;

player addEventHandler ["HandleDamage", {_this exec "WarZones_Handler_Player_HandleDamage.sqf"}];
["Client: Local Handler Created: HandleDamage"] call WarZones_fnc_Debug;

// End Client Init