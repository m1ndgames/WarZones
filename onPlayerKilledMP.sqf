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
			if (_killeruid == "") exitWith {};

			_killerscore = [_killeruid, "score", 1] call stats_get;
			_killerscore = _killerscore + 10;
			[_killeruid, "score", _killerscore] call stats_set;

			["Kill: +10 Pts.","hintSilent", _killer,true,true] call BIS_fnc_MP;
		};
	};
};