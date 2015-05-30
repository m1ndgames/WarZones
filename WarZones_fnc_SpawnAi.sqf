// WarZones_Initialize_Server_Loop_AiSpawn.sqf
/////////////////////////////////////////////////////////////////////////////////////
INDEPENDENT_HQ = createCenter resistance;
UnitsBase = [];
UnitsReinforcements = [];

if (Sector_Config_Area_Type == "infantry") then {
	[] call WarZones_fnc_SpawnAiInfantry;
};

if (Sector_Config_Area_Type == "tanks") then {
	[] call WarZones_fnc_SpawnAiTanks;
};

if (Sector_Config_Area_Type == "motorized") then {
	[] call WarZones_fnc_SpawnAiMotorized;
};

if (Sector_Config_Area_Type == "helicopters") then {
	[] call WarZones_fnc_SpawnAiHelicopters;
};

{
	_x addEventHandler ["Killed",
	{
		_killer = _this select 1;
		_killeruid = getPlayerUID _killer;
		if (_killeruid == "") exitWith {};
		_killerscore = [_killeruid, "score", 1] call stats_get;
		_killerscore = _killerscore + 5;
		[_killeruid, "score", _killerscore] call stats_set;
		[format ["Ai killed by UID %1 - Player score: %2", _killeruid, _killerscore]] call WarZones_fnc_Debug;
	}];
} forEach UnitsBase;


[] spawn {
	sleep 30;
	while {true} do {
		sleep 120;
		_aaftickets = [resistance] call BIS_fnc_respawnTickets;
		if (_aaftickets > 1) then {
			_aafforcescount = count UnitsBase;
			if (_aafforcescount < 6) then {
				["Less then 5 AAF Base Units, starting Halo-Loop and sending the 1st Drop"] call WarZones_fnc_Debug;
				[] call WarZones_fnc_SpawnAiReinforcements;
				[resistance,-10] call BIS_fnc_respawnTickets;
				while {true} do {
					sleep 120;
					_trooperscount = count UnitsReinforcements;
					if (_trooperscount < 3) then {
						[] call WarZones_fnc_SpawnAiReinforcements;
						[resistance,-10] call BIS_fnc_respawnTickets;
					};
				};
			};
		} else {
			// Nothing
			//["AAF Troops have been eliminated!","hint",true,true] call BIS_fnc_MP;
		};
	};
};