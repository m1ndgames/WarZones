if (!isServer) exitWith {};

["Started AAF Paradrop"] call WarZones_fnc_Debug;
["AAF HALO detected!","hint",true,true] call BIS_fnc_MP;

/////////////////////////////////
// Create 1st Paratroopers Squad
_group1position = getPos base_independent_flagpole findEmptyPosition [1,25];
_paratroopers1 = [_group1position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;

// Make them Halo
{
	[_x, 2000, true, true, true] call COB_fnc_HALO;
} forEach units _paratroopers1;

// Give Patrol orders to the 1st group
[_paratroopers1, getPos base_independent_flagpole, 75, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "", [3,7,15]] call CBA_fnc_taskPatrol;

// Move all units of group 1 into an array
{ UnitsReinforcements pushBack _x; } forEach units _paratroopers1;

/////////////////////////////////
// Create 2nd Paratroopers Squad
_group2position = getPos base_independent_flagpole findEmptyPosition [1,25];
_paratroopers2 = [_group2position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;

// Make them Halo
{
	[_x, 2000, true, true, true] call COB_fnc_HALO;
} forEach units _paratroopers2;

// Give Patrol orders to the 2nd group
[_paratroopers2, getPos base_independent_flagpole, 75, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "", [3,7,15]] call CBA_fnc_taskPatrol;

// Move all units of group 2 into an array
{ UnitsReinforcements pushBack _x; } forEach units _paratroopers2;