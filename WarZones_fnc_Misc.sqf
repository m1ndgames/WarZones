/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_Debug.sqf
/  Description: Function handles Debug Messages to the Logfile or Systemchat
/
*/

PointsBox = {
	_val = _this select 0;
	if (_val == 5) then {
		cutRsc ["Points5Box","PLAIN"];
	};
	if (_val == 10) then {
		cutRsc ["Points10Box","PLAIN"];
	};
};

ReinforcementsBox = {
	cutRsc ["ReinforcementsBox","PLAIN"];
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Server only
if (!isServer) exitWith {};

findPlayerViaUID = {
   private ["_player"];
   _player = objNull;
   {
     if (getPlayerUID _x == _this select 0) exitWith {
          _player = _x;
     };
   } forEach playableUnits;
   _player;
};

AiKilled = {
	_killer = _this select 1;
	_killeruid = getPlayerUID _killer;
	if (_killeruid == "") exitWith {};
	_killerscore = [_killeruid, "score", 1] call stats_get;
	_killerscore = _killerscore + 5;
	[_killeruid, "score", _killerscore] call stats_set;
	[format ["Ai killed by UID %1 - Player score: %2", _killeruid, _killerscore]] call WarZones_fnc_Debug;
	[{[5] call PointsBox;},"BIS_fnc_spawn", _killer, true, true] call BIS_fnc_MP;
};

PlayerKilled = {
	_victim = _this select 0;
	_killer = _this select 1;
	_killeruid = getPlayerUID _killer;
	if (_killeruid == "") exitWith {};
	_killerscore = [_killeruid, "score", 1] call stats_get;
	_killerscore = _killerscore + 10;
	[_killeruid, "score", _killerscore] call stats_set;
	[format ["%1 killed by %2 - Player score: %3", name _victim, name _killer, _killerscore]] call WarZones_fnc_Debug;
	[{[10] call PointsBox;},"BIS_fnc_spawn", _killer, true, true] call BIS_fnc_MP;
};