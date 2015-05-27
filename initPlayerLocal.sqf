// WarZones_Initialize_Client.sqf
/////////////////////////////////////////////////////////////////////////////////////
if (player != player) then {
	waitUntil {player == player};
};

["Client: Initializing..."] call WarZones_fnc_debug;

// Enable HUD
showHUD true;
["Client: HUD enabled"] call WarZones_fnc_debug;

// Disable NPC Talk
player disableConversation true;
["Client: Disabled conversations"] call WarZones_fnc_debug;

// Create Diary
[] spawn WarZones_fnc_CreateDiary;
["Client: Diary created"] call WarZones_fnc_debug;

_drawmaphandler = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{ [] call WarZones_fnc_drawmap; }];
["Client: Local Handler Created: Draw"] call WarZones_fnc_debug;

player addEventHandler ["HandleDamage", {_this exec "WarZones_hnd_Player_HandleDamage.sqf"}];
["Client: Local Handler Created: HandleDamage"] call WarZones_fnc_Debug;

// Add player Menu
_settings = [["Settings", "WarZones_fnc_PlayerMenu.sqf"]] call CBA_fnc_addPlayerAction;

// wait for BIS_fnc_init == true
// End Client Init