// WarZones_Initialize_Server_Loop_AiSpawn.sqf
/////////////////////////////////////////////////////////////////////////////////////

if (Sector_Config_Area_Type == "infantry") then {
	// Heli Drop - 2000m - Smoke
	nul = [base_independent_flagpole,3,true,2,[15,0],100,[0.2,0.5,0.1,0.4,0.2,0.5,0.4,0.3,0.5,0.5],nil,nil,2] execVM "LV\fillHouse.sqf";
	["Spawned AAF Units with fillHouse Template"] call WarZones_fnc_Debug;
};

if (Sector_Config_Area_Type == "tanks") then {
	// Spawn motorized AAF Units
	nul = [base_independent_flagpole,3,150,[true,false],[true,false,false],false,[15,0],[3,0],[0.5,0.5,0.1,0.1,0.2,0.5,0.4,0.3,0.5,0.5],nil,nil,2] execVM "LV\militarize.sqf";
};

if (Sector_Config_Area_Type == "motorized") then {
	// Spawn motorized AAF Units
	nul = [base_independent_flagpole,3,150,[true,false],[true,false,false],false,[15,0],[3,0],[0.5,0.5,0.1,0.1,0.2,0.5,0.4,0.3,0.5,0.5],nil,nil,2] execVM "LV\militarize.sqf";
};

if (Sector_Config_Area_Type == "helicopters") then {
	// Spawn Air AAF Units
	nul = [base_independent_flagpole,3,150,[true,false],[false,false,true],false,[15,0],[3,0],[0.5,0.5,0.1,0.1,0.2,0.5,0.4,0.3,0.5,0.5],nil,nil,2] execVM "LV\militarize.sqf";
};

[] spawn {
	scopeName "checkaaf";
	while {true} do {
		sleep 120;
		_aaftickets = [resistance] call BIS_fnc_respawnTickets;
		if (_aaftickets > 1) then {
			_aafforcescount = count units LVgroup2;
			if (_aafforcescount < 5) then {
				["Less then three AAF Base Units, starting Halo-Loop and sending the 1st Drop"] call WarZones_fnc_Debug;
				nul = [base_independent_flagpole,3,true,false,2000,"random",true,200,50,10,0.1,100,true,false,false,true,["PATROL",(getPos base_independent_flagpole), 100],false,[0.5,0.5,0.1,0.4,0.2,0.5,0.4,0.3,0.5,0.4],nil,nil,1,false] execVM "LV\heliParadrop.sqf";
				[resistance,-10] call BIS_fnc_respawnTickets;
				["AAF Troops incoming!","hint",true,true] call BIS_fnc_MP;
				scopeName "helispawn";
				while {true} do {
					sleep 120;
					_trooperscount = count units LVgroup1;
					if (_trooperscount < 3) then {
						nul = [base_independent_flagpole,3,true,false,2000,"random",true,200,50,10,0.1,100,true,false,false,true,["PATROL",(getPos base_independent_flagpole), 100],false,[0.5,0.5,0.1,0.4,0.2,0.5,0.4,0.3,0.5,0.4],nil,nil,1,false] execVM "LV\heliParadrop.sqf";
						["Started AAF Paradrop"] call WarZones_fnc_Debug;
						[resistance,-10] call BIS_fnc_respawnTickets;
						["AAF Troops incoming!","hint",true,true] call BIS_fnc_MP;
					};
				};
			};
		} else {
			// Nothing
			//["AAF Troops have been eliminated!","hint",true,true] call BIS_fnc_MP;
		};
	};
};