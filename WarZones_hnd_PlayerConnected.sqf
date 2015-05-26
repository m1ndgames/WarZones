_id = _this select 0;
_uid = _this select 1;
_name = _this select 2;

if (_name == "__SERVER__") then {
	["Server connected..."] call WarZones_fnc_Debug;
} else {
	[format ["Handler > PlayerConnected > UID: %1 | Name = %2", _uid, _name]] call WarZones_fnc_Debug;

	// Check if there is a saved Player profile
	[_uid] call WarZones_fnc_DBCheckPlayer;

	// Read Player Score from DB
//	_dbscore = ["read", "playerscore", _uid, nil] call WarZones_fnc_DB;
//	["addplayer",_name,100] call WarZones_fnc_score;
};