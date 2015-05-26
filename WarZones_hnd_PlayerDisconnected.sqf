_id = _this select 0;
_uid = _this select 1;
_name = _this select 2;

if (_name == "__SERVER__") then {
	["Server disconnected..."] call WarZones_fnc_Debug;
} else {
	[format ["Handler > PlayerDisconnected > UID: %1 | Name = %2", _uid, _name]] call WarZones_fnc_Debug;
};