/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_NPCspawn.sqf
/  Description: This function spawns the Ai dependent on the mission template.
/               The _param is the selected mission parameter (Class: Skill)
/
*/

// Fill array with all connected Players
_allPlayers = [];
{
	if (isPlayer _x) then
	{
		_allPlayers pushBack _x;
	};
} forEach playableUnits;

// Count the current Players
_playerscount = count _allPlayers;

// When Groupsize bigger then connected players: breakout to loop
 if (count (units INDEPENDENT_Group) > _playerscount) then {
 	breakOut "aispawn";
 };

// Create Heli Group
HELI_Group = createGroup INDEPENDENT_HQ;

// Create Transport Heli
heli = createVehicle ["I_Heli_Transport_02_F", getpos base_independent_flagpole, [], 3000, "FLY"];
heli flyInHeight 300; ["Spawned AAF Heli"] call WarZones_fnc_Debug;

// Assign heli to group
[heli] join HELI_Group;

// Create Heli Crew
createVehicleCrew heli; ["Created AAF Heli Crew"] call WarZones_fnc_Debug;

// Count empty seats
_helicargo = heli emptyPositions "cargo";

// Group cant be greater then cargo space
_groupsize = _playerscount *2;
if (_groupsize > _helicargo) then {
	_groupsize = _helicargo;
};

// Create random AAF group with defined groupsize
TROOPER_Group = [getPos heli, resistance, _groupsize] call BIS_fnc_spawnGroup; ["Created AAF Trooper Group"] call WarZones_fnc_Debug;

// Move Troopers into Heli Cargo
{
	_x moveInCargo heli;
	[_x] join INDEPENDENT_Group;
} forEach units TROOPER_Group;

// Delete the empty Trooper Group
deleteGroup TROOPER_Group; ["Deleted AAF Trooper Group"] call WarZones_fnc_Debug;

// Set waypoint (AAF Base)
_waypoint_aaf = HELI_Group addWaypoint [getpos base_independent_flagpole, 0];
_waypoint_aaf setWaypointCompletionRadius 50;

// Create Trigger on AAF Base
_unload = createTrigger ["EmptyDetector", getpos base_independent_flagpole];
_unload setTriggerArea [100, 100, 0, false];
_unload setTriggerActivation ["GUER", "PRESENT", true];
_unload setTriggerStatements ["this", "hint 'Heli in Zone'", "hint 'Heli left Zone'"]; // Todo: Insert/Halo

// Move Heli away
_despawn = HELI_Group addWaypoint [[0,150,0], 0]; heli flyInHeight 500;

// Check heli distance to AAF base and de-spawn
scopeName "checkdistance";
while {true} do {
	_distance = [heli, getpos base_independent_flagpole] call BIS_fnc_distance2D;
	if (_distance > 3000) then {
		deleteVehicle heli;
		["AAF Chopper: Despawned"] call WarZones_fnc_Debug;
		breakOut "checkdistance";
	};
	sleep 5;
};