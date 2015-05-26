if (!isServer) exitWith {};

_playerobject = _this select 2;

[format ["Handler > Teamswitch > Player: %1 | Old Unit: %2| New Unit: %3", name _playerobject, _from, _to]] call WarZones_fnc_Debug;