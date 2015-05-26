_victim = _this select 0;
_killer = _this select 1;

if (!isPlayer _victim) exitWith {};

if (_victim == _killer) then {
	[format ["Handler > MPKilled > %1 killed himself", _victim]] call WarZones_fnc_Debug;
	[_victim] spawn WarZones_fnc_CheckGear;
} else {
	[format ["Handler > MPKilled > %1 killed %2", _victim, _killer]] call WarZones_fnc_Debug;
	[_victim] spawn WarZones_fnc_CheckGear;
};