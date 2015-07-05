if (!isServer) exitWith {};

///////////////////
// Create Snipers
_sniper1randpos = [getPos base_independent_flagpole, random 100, random 360] call BIS_fnc_relPos;
_sniper1pos = _sniper1randpos findEmptyPosition [1,50];
_sniper1 = [_sniper1pos, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;
//[_sniper1, getPos base_independent_flagpole, 150, 15, true] call CBA_fnc_taskDefend;

sleep 1;

/*

///////////////////
// Create patrol
_patrol1randpos = [getPos base_independent_flagpole, random 100, random 360] call BIS_fnc_relPos;
_patrol1pos = _patrol1randpos findEmptyPosition [1,50];
_patrol1 = [_patrol1pos, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
//[_patrol1, getPos base_independent_flagpole, 50, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;

sleep 1;

_patrol2randpos = [getPos base_independent_flagpole, random 100, random 360] call BIS_fnc_relPos;
_patrol2pos = _patrol2randpos findEmptyPosition [1,50];
_patrol2 = [_patrol2pos, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
//[_patrol2, getPos base_independent_flagpole, 60, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;

sleep 1;

_patrol3randpos = [getPos base_independent_flagpole, random 100, random 360] call BIS_fnc_relPos;
_patrol3pos = _patrol3randpos findEmptyPosition [1,50];
_patrol3 = [_patrol3pos, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
//[_patrol3, getPos base_independent_flagpole, 70, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;

sleep 1;

_patrol4randpos = [getPos base_independent_flagpole, random 100, random 360] call BIS_fnc_relPos;
_patrol4pos = _patrol4randpos findEmptyPosition [1,50];
_patrol4 = [_patrol4pos, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
//[_patrol4, getPos base_independent_flagpole, 80, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;


/////////////////////////////////////
// Push all Base Units into an Array

*/

// Snipers
{ UnitsBase pushBack _x; } forEach units _sniper1;

/*

// Patrol
{ UnitsBase pushBack _x; } forEach units _patrol1;
{ UnitsBase pushBack _x; } forEach units _patrol2;
{ UnitsBase pushBack _x; } forEach units _patrol3;
{ UnitsBase pushBack _x; } forEach units _patrol4;

sleep 0.1;

*/

[format ["Spawned %1 AAF Base Units: Infantry", count UnitsBase]] call WarZones_fnc_Debug;