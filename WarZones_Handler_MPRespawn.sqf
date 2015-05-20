_unit = _this select 0;
_unituid = getPlayerUID _unit;
_corpse = _this select 1;

if (_corpse == objNull) then {
	// Joined Player
	[format ["Handler > MPRespawn > Player %1 joined, UID: %2", name _unit, _unituid]] call WarZones_fnc_Debug;
	[_unit] call WarZones_fnc_CheckGear;

	_selected = missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_selected",""];
	[format ["Selected Gear: %1", _selected]] call WarZones_fnc_Debug;

	if (_selected == "Pilot") then {
		_unit setVariable ["Pilot",true];
	} else {
		if (_selected == "Crewman") then {
			_unit setVariable ["Crewman",true];
		} else {
			if (_selected == "Medic") then {
				_unit setVariable ["ace_medical_medicClass",1];
			} else {
				if (_selected == "Doctor") then {
					_unit setVariable ["ace_medical_medicClass",2];
				} else {
					_unit setVariable ["Pilot",false];
					_unit setVariable ["Crewman",false];
					_unit setVariable ["ace_medical_medicClass",0];
				};
			};
		};
	};
} else {
	// Respawned Player
	[format ["Handler > MPRespawn > Player %1 respawned, Corpse Location: %2", name _unit, getPos _corpse]] call WarZones_fnc_Debug;
	[_unit] call WarZones_fnc_CheckGear;

	_selected = missionnamespace getvariable ["BIS_fnc_respawnMenuInventory_selected",""];
	[format ["Selected Gear: %1", _selected]] call WarZones_fnc_Debug;

	if (_selected == "Pilot") then {
		_unit setVariable ["Pilot",true];
	} else {
		if (_selected == "Crewman") then {
			_unit setVariable ["Crewman",true];
		} else {
			if (_selected == "Medic") then {
				_unit setVariable ["ace_medical_medicClass",1];
			} else {
				if (_selected == "Doctor") then {
					_unit setVariable ["ace_medical_medicClass",2];
				} else {
					_unit setVariable ["Pilot",false];
					_unit setVariable ["Crewman",false];
					_unit setVariable ["ace_medical_medicClass",0];
				};
			};
		};
	};
};