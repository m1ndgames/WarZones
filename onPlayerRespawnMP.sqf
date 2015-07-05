/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: onPlayerRespawnMP.sqf
/  Description: "Respawn" MPEventhandler - Handles Player respawns
/
*/
if (!isServer) exitWith {};

_playerobject = _this select 0;
_playerobjectuid = getPlayerUID _playerobject;
_playercorpse = _this select 1;

if (_playercorpse == objNull) then {
	// Joined Player
	[format ["Handler > onPlayerRespawn > Player %1 joined, UID: %2", name _playerobject, _playerobjectuid]] call WarZones_fnc_Debug;

} else {
	// Respawned Player
	[format ["Handler > onPlayerRespawn > Player %1 respawned, Corpse Location: %2", name _playerobject, getPos _playercorpse]] call WarZones_fnc_Debug;

	_selected = missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_selected",""];
	[format ["Selected Gear: %1", _selected]] call WarZones_fnc_Debug;

	if (_selected == "Pilot") then {
		_playerobject setVariable ["Pilot",true];
	} else {
		if (_selected == "Crewman") then {
			_playerobject setVariable ["Crewman",true];
		} else {
			if (_selected == "Medic") then {
				_playerobject setVariable ["Medic",true];
			} else {
				_playerobject setVariable ["Pilot",false];
				_playerobject setVariable ["Crewman",false];
				_playerobject setVariable ["Medic",false];
			};
		};
	};
};

// End of File: onPlayerRespawnMP.sqf
