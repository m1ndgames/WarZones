
_sentry1 = [getPos base_independent_flagpole, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
_sentry2 = [getPos base_independent_flagpole, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
_sentry3 = [getPos base_independent_flagpole, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
_sentry4 = [getPos base_independent_flagpole, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;

SENTRYGROUP = createGroup INDEPENDENT_HQ;
[units _sentry1] join SENTRYGROUP;
[units _sentry2] join SENTRYGROUP;
[units _sentry3] join SENTRYGROUP;
[units _sentry4] join SENTRYGROUP;

[SENTRYGROUP, getPos base_independent_flagpole, 75, 10, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [5,10,15]] call CBA_fnc_taskPatrol;

_sniper1 = [getPos base_independent_flagpole, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_SniperTeam")] call BIS_fnc_spawnGroup;
_infteam1 = [getPos base_independent_flagpole, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
_infteam2 = [getPos base_independent_flagpole, resistance, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;

DEFENDGROUP = createGroup INDEPENDENT_HQ;
[units _sniper1] join DEFENDGROUP;
[units _infteam1] join DEFENDGROUP;
[units _infteam2] join DEFENDGROUP;
[DEFENDGROUP, getPos base_independent_flagpole, 75, 3, true] call CBA_fnc_taskDefend

[units SENTRYGROUP] join BASEGROUP;
[units DEFENDGROUP] join BASEGROUP;

sleep 0.1;
["Spawned AAF Base Units: Infantry"] call WarZones_fnc_Debug;