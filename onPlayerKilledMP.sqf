if (!isServer) exitWith {};

_victim = _this select 0;
_victimuid = getPlayerUID _victim;

_killer = _this select 1;
_killeruid = getPlayerUID _killer;

if (!isPlayer _victim) then {
	// Nothing
} else {
	if (_victim == _killer) then {
		[format ["Handler > onPlayerKilledMP > %1 killed himself", _victim]] call WarZones_fnc_Debug;
		[_victim, _victimuid] spawn WarZones_fnc_CheckGear;

	} else {
		[format ["Handler > onPlayerKilledMP > %1 was killed by %2", name _victim, name _killer]] call WarZones_fnc_Debug;
		[_victim, _victimuid] spawn WarZones_fnc_CheckGear;
		if (isPlayer _killer) then {
			[_victim,_killer] spawn PlayerKilled;
		};
	};
};