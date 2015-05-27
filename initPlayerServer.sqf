if (!isServer) exitWith {};

_playerobject = _this select 0;
_playeruid = getPlayerUID _playerobject;

_mprespawnhandler = _playerobject addMPEventHandler ["mprespawn", {Null = _this execVM "onPlayerRespawnMP.sqf";}];
["MP Handler Created: Respawn"] call WarZones_fnc_Debug;

_mpkilledhandler = _playerobject addMPEventHandler ["mpkilled", {Null = _this execVM "onPlayerKilledMP.sqf";}];
["MP Handler Created: Killed"] call WarZones_fnc_Debug;

// Check if there is a saved Player profile
[_playeruid] call WarZones_fnc_DBCheckPlayer;