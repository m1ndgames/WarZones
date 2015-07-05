/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: initPlayerServer.sqf
/  Description: This init script is executed by server, but run on the clients when the mission is started. (Before briefing screen)
/
*/
if (!isServer) exitWith {};

_playerobject = _this select 0;
_playeruid = getPlayerUID _playerobject;

_mprespawnhandler = _playerobject addMPEventHandler ["mprespawn", {Null = _this execVM "onPlayerRespawnMP.sqf";}];
["MP Handler Created: Respawn"] call WarZones_fnc_Debug;

_mpkilledhandler = _playerobject addMPEventHandler ["mpkilled", {Null = _this execVM "onPlayerKilledMP.sqf";}];
["MP Handler Created: Killed"] call WarZones_fnc_Debug;

// Check if there is a saved Player profile
[_playeruid] call WarZones_fnc_DBCheckPlayer;

// End of File: InitPlayerServer.sqf