_unit = _this select 0;
_unituid = getPlayerUID _unit;
_corpse = _this select 1;

if (_corpse == objNull) then {
	// Joined Player
	[format ["Handler > MPRespawn > Player %1 joined, UID: %2", name _unit, _unituid]] call WarZones_fnc_Debug;
	[_unit] call WarZones_fnc_CheckGear;
} else {
	// Respawned Player
	[format ["Handler > MPRespawn > Player %1 respawned, Corpse Location: %2", name _unit, getPos _corpse]] call WarZones_fnc_Debug;
	[_unit] call WarZones_fnc_CheckGear;
};