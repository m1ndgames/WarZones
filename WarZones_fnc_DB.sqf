/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_DB.sqf
/  Description: Function handles Database read/write
/
/  Not working!
/
*/

if (!isServer) exitWith {};

_param = _this select 0; // Can be read or write
_type = _this select 1; // Can be playerscore or playerconnects
_playeruid = _this select 2; // player uid
_value = _this select 3; // Value that should be written into the DB

if (_param == "read") then {
	if (_type == "playerscore") then {	// _dbscore = ["read", "playerscore", _playerobject] call WarZones_fnc_DB;
		_return = 100;
	};

	if (_type == "playerconnects") then {	// _dbconnects = ["read", "playerconnects", _playerobject] call WarZones_fnc_DB;

	};
};

if (_param == "write") then {
	if (_type == "playerscore") then {	// ["write", "playerscore", _playerobject, 100] call WarZones_fnc_DB;

	};

	if (_type == "playerconnects") then {	// ["write", "playerconnects", _playerobject] call WarZones_fnc_DB;

	};
};