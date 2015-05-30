// WarZones_Initialize_Server_Loop_AiSpawn.sqf
/////////////////////////////////////////////////////////////////////////////////////

waitUntil {time > 20};

{
	_x addeventhandler ["Killed",{
		_victim = _this select 0;
		_killer = _this select 1;
		[_victim,_killer] spawn AiKilled;
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