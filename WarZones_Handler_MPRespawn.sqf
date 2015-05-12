_unit = _this select 0;
_unituid = getPlayerUID _unit;
_corpse = _this select 1;

if (!isNil "_corpse") then {
	// Joined Player
	[format ["Handler > MPRespawn > Player %1 joined", name _unit]] call WarZones_fnc_Debug;
} else {
	// Respawned Player
	[format ["Handler > MPRespawn > Player %1 respawned", name _unit]] call WarZones_fnc_Debug;
};