if (!isServer) exitWith {};

["Started AAF Paradrop"] call WarZones_fnc_Debug;
[{[] call ReinforcementsBox;},"BIS_fnc_spawn",  true, true] call BIS_fnc_MP;

/////////////////////////////////
// Create 1st Paratroopers Squad
_group1randpos = [getPos base_independent_flagpole, random 100, random 360] call BIS_fnc_relPos;
_group1position = _group1randpos findEmptyPosition [1,50];
_paratroopers1 = [_group1position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
//[_paratroopers1, getPos base_independent_flagpole, 100, 7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;

// Make them Halo
{
	[_x, 2000, true, true, true] call COB_fnc_HALO;
} forEach units _paratroopers1;

// Move all units of group 1 into an array
{ UnitsReinforcements pushBack _x; } forEach units _paratroopers1;

/////////////////////////////////
// Create 2nd Paratroopers Squad
_group2randpos = [getPos base_independent_flagpole, random 100, random 360] call BIS_fnc_relPos;
_group2position = _group2randpos findEmptyPosition [1,50];
_paratroopers2 = [_group2position, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
//[_paratroopers2, getPos base_independent_flagpole, 100,7, "MOVE", "SAFE", "RED", "LIMITED", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,7,15]] call CBA_fnc_taskPatrol;

// Make them Halo
{
	[_x, 2000, true, true, true] call COB_fnc_HALO;
} forEach units _paratroopers2;

// Move all units of group 2 into an array
{ UnitsReinforcements pushBack _x; } forEach units _paratroopers2;

{
	_x addeventhandler ["Killed",{
		_victim = _this select 0;
		_killer = _this select 1;
		[_victim,_killer] spawn AiKilled;
	}];
} forEach UnitsReinforcements;

// Add Reinforcements to DAC
// [UnitsReinforcements,1,[aafzoneinf],10,2,2,[0,0,0],0,false] spawn DAC_fInsertGroup;