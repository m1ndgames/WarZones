// MP Handler: MPKilled
player addMPEventHandler ["MPKilled", {_this execVM "WarZones_Handler_MPKilled.sqf";}]; ["MP Handler Created: MPKilled"] call WarZones_fnc_Debug;


// MP Handler: MPHit
player addMPEventHandler ["MPHit", {_this execVM "WarZones_Handler_MPHit.sqf";}]; ["MP Handler Created: MPHit"] call WarZones_fnc_Debug;


// MP Handler: MPRespawn
player addMPEventHandler ["MPRespawn",{_this execVM "WarZones_Handler_MPRespawn.sqf";}]; ["MP Handler Created: MPRespawn"] call WarZones_fnc_Debug;

// Local Handler on Server > On Player Connect
onPlayerConnected "[_id, _uid, _name] execVM ""WarZones_Handler_PlayerConnected.sqf"""; ["Server: Local Handler Created: OnPlayerConnected"] call WarZones_fnc_Debug;

// Local Handler on Server > On Player Disconnect
onPlayerDisconnected "[_id, _uid, _name] execVM ""WarZones_Handler_PlayerDisconnected.sqf"""; ["Server: Local Handler Created: OnPlayerDisconnected"] call WarZones_fnc_Debug;