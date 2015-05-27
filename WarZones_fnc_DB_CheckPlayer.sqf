/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_DB_PlayerCheck.sqf
/  Description: This function checks a player, if new, he's added to the db.
/
*/
if (!isServer) exitWith {};

_playeruid = _this select 0; // Player UID
_dbuid = [_playeruid, "uid", "none"] call stats_get;
_playerobject = [_playeruid] call findPlayerViaUID;

// No Data found, we save the player to the db
if (_dbuid == "none") then {
	[format ["DB --> PlayerCheck -> Creating DB for new Player with UID %1", _playeruid]] call WarZones_fnc_Debug;
	[_playeruid, ["uid", _playeruid],["joincount", 1],["joindate", date],["isbanned", 0],["score", 1]] call stats_set;

//	Found player data...
} else {
	_joincount = [_playeruid, "joincount", 1] call stats_get;
	_joincount = _joincount +1;
	[_dbuid, "joincount", _joincount] call stats_set;
	[format ["DB --> PlayerCheck -> Found Player with UID %1 - %2 joins", _dbuid, _joincount]] call WarZones_fnc_Debug;
};