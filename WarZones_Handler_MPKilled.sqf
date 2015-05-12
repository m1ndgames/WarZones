_victim = _this select 0;
_killer = _this select 1;

_suicide = 0;

if (_victim == _killer) then {
	_suicide = 1;
};

if (_suicide == 1) then {
	[format ["Handler > MPKilled > %1 killed himself", _victim]] call WarZones_fnc_Debug;
} else {
	[format ["Handler > MPKilled > %1 killed %2", _victim, _killer]] call WarZones_fnc_Debug;
};