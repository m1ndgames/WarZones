///////////////////
// Create Sentries
_position = getPos base_independent_flagpole findEmptyPosition [1,10];
_sentry1 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

_position = getPos base_independent_flagpole findEmptyPosition [10,25];
_sentry2 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

_position = getPos base_independent_flagpole findEmptyPosition [25,50];
_sentry3 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

_position = getPos base_independent_flagpole findEmptyPosition [50,75];
_sentry4 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

// Sentries find a house and dont patrol
[_sentry1, getPos base_independent_flagpole, 150, 3, true] call CBA_fnc_taskDefend;
[_sentry2, getPos base_independent_flagpole, 150, 3, true] call CBA_fnc_taskDefend;
[_sentry3, getPos base_independent_flagpole, 150, 3, true] call CBA_fnc_taskDefend;
[_sentry4, getPos base_independent_flagpole, 150, 3, true] call CBA_fnc_taskDefend;


///////////////////
// Create Snipers
_position = getPos base_independent_flagpole findEmptyPosition [1,10];
_sniper1 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;

_position = getPos base_independent_flagpole findEmptyPosition [50,75];
_sniper2 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;

// Snipers look for bigger houses in a bigger area, they dont patrol
[_sniper1, getPos base_independent_flagpole, 500, 15, true] call CBA_fnc_taskDefend; // Big white House in Kavala
[_sniper2, getPos base_independent_flagpole, 500, 15, true] call CBA_fnc_taskDefend;


///////////////////
// Create patrol
_position = getPos base_independent_flagpole findEmptyPosition [1,25];
_patrol1 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

_position = getPos base_independent_flagpole findEmptyPosition [1,25];
_patrol2 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

_position = getPos base_independent_flagpole findEmptyPosition [25,50];
_patrol3 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

_position = getPos base_independent_flagpole findEmptyPosition [25,50];
_patrol4 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

// Orders: Patrol and search houses
[_patrol1, getPos base_independent_flagpole, 150, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;
[_patrol2, getPos base_independent_flagpole, 150, 8, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;
[_patrol3, getPos base_independent_flagpole, 150, 9, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;
[_patrol4, getPos base_independent_flagpole, 150, 10, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;


///////////////////
// Create UAV Team
_position = getPos base_independent_flagpole findEmptyPosition [1,50];
_uav1 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "SpecOps" >> "HAF_SmallTeam_UAV")] call BIS_fnc_spawnGroup;
[_uav1, getPos base_independent_flagpole, 150, 3, false] call CBA_fnc_taskDefend;


///////////////////
// Create Mech Anti Air Team
_position = getPos base_independent_flagpole findEmptyPosition [1,50];
_mechaa1 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Mechanized" >> "HAF_MechInf_AA")] call BIS_fnc_spawnGroup;
[_mechaa1, getPos base_independent_flagpole, 150, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "", [3,7,15]] call CBA_fnc_taskPatrol;


///////////////////
// Create Motorized MG Team
_position = getPos base_independent_flagpole findEmptyPosition [1,50];
_motmg1 = [_position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Motorized_MTP" >> "HAF_MotInf_MGTeam")] call BIS_fnc_spawnGroup;
[_motmg1, getPos base_independent_flagpole, 150, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "", [3,7,15]] call CBA_fnc_taskPatrol;


/////////////////////////////////////
// Push all Base Units into an Array

// Sentries
{ UnitsBase pushBack _x; } forEach units _sentry1;
{ UnitsBase pushBack _x; } forEach units _sentry2;
{ UnitsBase pushBack _x; } forEach units _sentry3;
{ UnitsBase pushBack _x; } forEach units _sentry4;

// Snipers
{ UnitsBase pushBack _x; } forEach units _sniper1;
{ UnitsBase pushBack _x; } forEach units _sniper2;

// Patrol
{ UnitsBase pushBack _x; } forEach units _patrol1;
{ UnitsBase pushBack _x; } forEach units _patrol2;
{ UnitsBase pushBack _x; } forEach units _patrol3;
{ UnitsBase pushBack _x; } forEach units _patrol4;

// UAV Team
{ UnitsBase pushBack _x; } forEach units _uav1;

// Mech Anti Air Team
{ UnitsBase pushBack _x; } forEach units _mechaa1;

// Motorized MG Team
{ UnitsBase pushBack _x; } forEach units _motmg1;

["Spawned AAF Base Units: Helicopters"] call WarZones_fnc_Debug;