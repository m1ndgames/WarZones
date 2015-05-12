_param = _this select 0;

if (_param == "init") then {
	["Initializing fal_teleport.sqf"] execVM "scripts\fal_debug.sqf"; // Initialize Teleport Module
	teleport_nato addAction ["Teleport - Airfield - aaf","scripts\fal_teleport.sqf",["respawn_west"]];
	teleport_aaf addAction ["Teleport - Airfield - nato","scripts\fal_teleport.sqf",["respawn_guerilla"]];
} else {
	// Get the destination.
	_dest = (_this select 3) select 0;

	// Get a random direction
	_dir = random 359;

	// Move the person 15 meters away from the destination (in the direction of _dir)
	player SetPos [(getMarkerPos _dest select 0)-10*sin(_dir),(getMarkerPos _dest select 1)-10*cos(_dir)];
}