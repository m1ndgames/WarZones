/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_CreateSectors.sqf
/  Description: Function that reads a random Sector and Base Template, and creates Sectors and Bases for the three Sides.
/
*/

// Load Sector Templates
#include "WarZones_Template_Sectors.hpp"; ["Loading Sector Templates"] call WarZones_fnc_Debug;

// Get a Random Template
_Random_Sectors = _Templates_Sector call BIS_fnc_selectRandom;

// Get Sector Config from Template
_Sector_Config = _Random_Sectors select 0;

// Get Config Values
_Sector_Config_Area_Size = _Sector_Config select 0;
Sector_Config_Area_Type = _Sector_Config select 1;
[format ["Sector Type: %1 - Sector Size: %2", Sector_Config_Area_Type, _Sector_Config_Area_Size]] call WarZones_fnc_Debug;

// Get Sectors from Template
_Sectors = [_Random_Sectors select 1, _Random_Sectors select 2];

// Shuffle the Sector Positions
_Shuffled_Sectors = _Sectors call BIS_fnc_arrayShuffle;

// BLUFOR Sector
_location_blufor = _Shuffled_Sectors select 0;
[format ["BLUFOR Position: %1", _location_blufor]] call WarZones_fnc_Debug;

// OPFOR Sector
_location_opfor = _Shuffled_Sectors select 1;
[format ["OPFOR Position: %1", _location_opfor]] call WarZones_fnc_Debug;

// Define x/y
_location_blufor_x = _location_blufor select 0;
_location_blufor_y = _location_blufor select 1;

_location_opfor_x = _location_opfor select 0;
_location_opfor_y = _location_opfor select 1;

//////////////////////
// Create Sectors

// BLUFOR
// Create Center Flagpole
base_blufor_flagpole = createVehicle ["Flag_NATO_F", [_location_blufor select 0, _location_blufor select 1], [], 0, "NONE"];
base_blufor_flagpole setVariable ["BIS_enableRandomization", false];

// Modify the Sector Trigger
sector_blufor_trigger setTriggerArea [_Sector_Config_Area_Size,_Sector_Config_Area_Size, 0, false ];
sector_blufor_trigger setPos getPos base_blufor_flagpole;

// Create Respawn Marker
_marker_RespawnBLUFOR = ["respawn_west", sector_blufor_trigger] call BIS_fnc_markerToTrigger;
_marker_RespawnBLUFOR setMarkerType "respawn_inf";
_marker_RespawnBLUFOR setMarkerAlpha 0;
["NATO marker created"] call WarZones_fnc_debug;

// OPFOR
// Create Center Flagpole
base_opfor_flagpole = createVehicle ["Flag_CSAT_F", [_location_opfor_x, _location_opfor_y], [], 0, "NONE"];
base_opfor_flagpole setVariable ["BIS_enableRandomization", false];

// Modify the Sector Trigger
sector_opfor_trigger setTriggerArea [_Sector_Config_Area_Size,_Sector_Config_Area_Size, 0, false ];
sector_opfor_trigger setPos getPos base_opfor_flagpole;

// Create Respawn Marker
_marker_RespawnOPFOR = ["respawn_east", sector_opfor_trigger] call BIS_fnc_markerToTrigger;
_marker_RespawnOPFOR setMarkerType "respawn_inf";
_marker_RespawnOPFOR setMarkerAlpha 0;
["CSAT marker created"] call WarZones_fnc_debug;

// Measure distance between BLUFOR and OPFOR
_distance = [base_blufor_flagpole, base_opfor_flagpole] call BIS_fnc_distance2D;
[format ["Distance between BLUFOR and OPFOR: %1", _distance]] call WarZones_fnc_Debug;

// Define half of the Distance
_distance_half = _distance / 2;

// Get Compass direction (from BLUFOR to OPFOR)
_direction = [base_opfor_flagpole,getPos base_blufor_flagpole] call BIS_fnc_relativeDirTo;

// Find center position between BLUFOR and OPFOR
_center = [base_opfor_flagpole, _distance_half, _direction] call BIS_fnc_relPos;

// Define center x/y
_center_x = _center select 0;
_center_y = _center select 1;

// Create Independent Center Flagpole
base_independent_flagpole = createVehicle ["Flag_AAF_F", [_center_x,_center_y], [], 0, "NONE"];
base_independent_flagpole setVariable ["BIS_enableRandomization", false];

_location_independent = getPos base_independent_flagpole;

/* ToDo: Find another way to set up bases in a triangle. With this code AAF base could be spawned on water...

// Add a 90° corner
_corner = _direction + 90;

// Define Independent Position
_location_independent = [base_independent_flagpole, _distance_half, _corner] call BIS_fnc_relPos;
[format ["Independent Position: %1", _location_independent]] call WarZones_fnc_Debug;

// Move the Position if it spawned on water
_location_independent_flat = selectBestPlaces [_location_independent, 150, "(1 - sea)", 1, 1];

// Define Independent Spawn x/y Location
_location_independent_x = ((_location_independent_flat select 0) select 0) select 0;
_location_independent_y = ((_location_independent_flat select 0) select 0) select 1;

// Move the Flagpole to final location
base_independent_flagpole setPos [_location_independent_x,_location_independent_y, 0];

*/

// Modify the Sector Trigger
sector_independent_trigger setTriggerArea [_Sector_Config_Area_Size,_Sector_Config_Area_Size, 0, false ];
sector_independent_trigger setPos getPos base_independent_flagpole;

// Create Respawn Marker
_marker_RespawnIndependent = ["respawn_guerrila", sector_independent_trigger] call BIS_fnc_markerToTrigger;
_marker_RespawnIndependent setMarkerAlpha 0;
["Independent marker created"] call WarZones_fnc_debug;

//// Spawn Bases

// Load Base Templates
#include "WarZones_Template_Bases.hpp"; ["Loading Base Templates"] call WarZones_fnc_Debug;

// Get Compass direction (from BLUFOR to INDEPENDENT)
_direction_BlU_IND = [base_blufor_flagpole,getPos base_independent_flagpole] call BIS_fnc_relativeDirTo;

// Get Compass direction (from OPFOR to INDEPENDENT)
_direction_OPF_IND = [base_opfor_flagpole,getPos base_independent_flagpole] call BIS_fnc_relativeDirTo;

if (Sector_Config_Area_Type == "motorized") then {
	// Get a Random Template
	_Base_Template = _Templates_Base_motorized call BIS_fnc_selectRandom;

	// Spawn BLUFOR Base (Facing Independent)
	_Base_BLUFOR = [_location_blufor,_direction_BlU_IND,_Base_Template] call BIS_fnc_ObjectsMapper;

	// Spawn OPFOR Base
	_Base_OPFOR = [_location_opfor,_direction_OPF_IND,_Base_Template] call BIS_fnc_ObjectsMapper;

	// Spawn Independent Base
	_Base_INDEPENDENT = [_location_independent,0,_Base_Template] call BIS_fnc_ObjectsMapper;
};

if (Sector_Config_Area_Type == "helicopters") then {
	// Get a Random Template
	_Base_Template = _Templates_Base_helicopters call BIS_fnc_selectRandom;

	// Spawn BLUFOR Base (Facing Independent)
	_Base_BLUFOR = [_location_blufor,_direction_BlU_IND,_Base_Template] call BIS_fnc_ObjectsMapper;

	// Spawn OPFOR Base
	_Base_OPFOR = [_location_opfor,_direction_OPF_IND,_Base_Template] call BIS_fnc_ObjectsMapper;

	// Spawn Independent Base
	_Base_INDEPENDENT = [_location_independent,0,_Base_Template] call BIS_fnc_ObjectsMapper;
};

if (Sector_Config_Area_Type == "tanks") then {
	// Get a Random Template
	_Base_Template = _Templates_Base_tanks call BIS_fnc_selectRandom;

	// Spawn BLUFOR Base (Facing Independent)
	_Base_BLUFOR = [_location_blufor,_direction_BlU_IND,_Base_Template] call BIS_fnc_ObjectsMapper;

	// Spawn OPFOR Base
	_Base_OPFOR = [_location_opfor,_direction_OPF_IND,_Base_Template] call BIS_fnc_ObjectsMapper;

	// Spawn Independent Base
	_Base_INDEPENDENT = [_location_independent,0,_Base_Template] call BIS_fnc_ObjectsMapper;
};
["Sectors created"] call WarZones_fnc_Debug;

////////////////////////////////////////////
// Vehicle respawn markers and restrictions

//// NATO
["Creating NATO vehicle respawn markers and handlers"] call WarZones_fnc_Debug;

// Cars
_nato_vehicles_car = [_location_blufor_x, _location_blufor_y] nearObjects ["Car", 100];
_nato_vehicles_car_num = 0;
{
	_nato_vehicles_car_num = _nato_vehicles_car_num + 1;
	_x setVariable ["BIS_enableRandomization", false];
	_nato_car_position = getPos _x;
	_x respawnVehicle [30, 0];
	[format ["Found %1 on %2", _x, _nato_car_position]] call WarZones_fnc_Debug;
	["--> Set Vehicle Respawn: 30 Seconds"] call WarZones_fnc_Debug;

	_nato_marker_string = Format ["respawn_vehicle_west_%1", str _nato_vehicles_car_num];
	createMarker [_nato_marker_string, position _x ];
	_nato_marker_string setMarkerAlpha 0.25;
	_nato_marker_string setMarkerType "respawn_motor";
	[format ["--> Vehicle Respawn marker created: %1", _nato_marker_string]] call WarZones_fnc_Debug;

	sleep 0.1;
} forEach _nato_vehicles_car;

// Tanks
_nato_vehicles_tank = [_location_blufor_x, _location_blufor_y] nearObjects ["Tank", 100];
_nato_vehicles_tank_num = 0;
{
	_nato_vehicles_tank_num = _nato_vehicles_tank_num + 1;
	_x setVariable ["BIS_enableRandomization", false];
	_nato_tank_position = getPos _x;
	_x respawnVehicle [60, 0];
	[format ["Found %1 on %2", _x, _nato_tank_position]] call WarZones_fnc_Debug;
	["--> Set Tank Respawn: 30 Seconds"] call WarZones_fnc_Debug;

	_nato_marker_string = Format ["respawn_vehicle_west_%1", str _nato_vehicles_tank_num];
	createMarker [_nato_marker_string, position _x ];
	_nato_marker_string setMarkerAlpha 0.25;
	_nato_marker_string setMarkerType "respawn_armor";
	[format ["--> Tank Respawn marker created: %1", _nato_marker_string]] call WarZones_fnc_Debug;

	sleep 0.1;
} forEach _nato_vehicles_tank;

// Air
_nato_vehicles_air = [_location_blufor_x, _location_blufor_y] nearObjects ["Air", 100];
_nato_vehicles_air_num = 0;
{
	_nato_vehicles_air_num = _nato_vehicles_air_num + 1;
	_x setVariable ["BIS_enableRandomization", false];
	_nato_air_position = getPos _x;
	_x respawnVehicle [120, 0];
	[format ["Found %1 on %2", _x, _nato_air_position]] call WarZones_fnc_Debug;
	["--> Set air Respawn: 30 Seconds"] call WarZones_fnc_Debug;

	_nato_marker_string = Format ["respawn_vehicle_west_%1", str _nato_vehicles_air_num];
	createMarker [_nato_marker_string, position _x ];
	_nato_marker_string setMarkerAlpha 0.25;
	_nato_marker_string setMarkerType "respawn_armor";
	[format ["--> Air Respawn marker created: %1", _nato_marker_string]] call WarZones_fnc_Debug;

	// Pilot restriction
	_x addEventHandler ["GetIn",{
	        if (_this select 1 == "driver") then {
	            if (!((_this select 2) in pilots)) then {
	                _this select 2 action ["eject",_this select 0]; hint "You are not authorized to pilot this vehicle!";
	            };
			};
	        if (_this select 1 == "gunner") then {
	            if (!((_this select 2) in pilots)) then {
	                _this select 2 action ["eject",_this select 0]; hint "You are not authorized to pilot this vehicle!";
	            };
			};
		}
	];

	["--> Pilot restriction enabled"] call WarZones_fnc_Debug;

	sleep 0.1;
} forEach _nato_vehicles_air;


//// CSAT
["Creating CSAT vehicle respawn markers and handlers"] call WarZones_fnc_Debug;

// Cars
_csat_vehicles_car = [_location_opfor_x, _location_opfor_y] nearObjects ["Car", 100];
_csat_vehicles_car_num = 0;
{
	_csat_vehicles_car_num = _csat_vehicles_car_num + 1;
	_x setVariable ["BIS_enableRandomization", false];
	_csat_car_position = getPos _x;
	_x respawnVehicle [30, 0];
	[format ["Found %1 on %2", _x, _csat_car_position]] call WarZones_fnc_Debug;
	["--> Set Vehicle Respawn: 30 Seconds"] call WarZones_fnc_Debug;

	_csat_marker_string = Format ["respawn_vehicle_east_%1", str _csat_vehicles_car_num];
	createMarker [_csat_marker_string, position _x ];
	_csat_marker_string setMarkerAlpha 0.25;
	_csat_marker_string setMarkerType "respawn_motor";
	[format ["--> Vehicle Respawn marker created: %1", _csat_marker_string]] call WarZones_fnc_Debug;

	sleep 0.1;
} forEach _csat_vehicles_car;

// Tanks
_csat_vehicles_tank = [_location_opfor_x, _location_opfor_y] nearObjects ["Tank", 100];
_csat_vehicles_tank_num = 0;
{
	_csat_vehicles_tank_num = _csat_vehicles_tank_num + 1;
	_x setVariable ["BIS_enableRandomization", false];
	_csat_tank_position = getPos _x;
	_x respawnVehicle [60, 0];
	[format ["Found %1 on %2", _x, _csat_tank_position]] call WarZones_fnc_Debug;
	["--> Set Tank Respawn: 30 Seconds"] call WarZones_fnc_Debug;

	_csat_marker_string = Format ["respawn_vehicle_east_%1", str _csat_vehicles_tank_num];
	createMarker [_csat_marker_string, position _x ];
	_csat_marker_string setMarkerAlpha 0.25;
	_csat_marker_string setMarkerType "respawn_armor";
	[format ["--> Tank Respawn marker created: %1", _csat_marker_string]] call WarZones_fnc_Debug;

	sleep 0.1;
} forEach _csat_vehicles_tank;

// Air
_csat_vehicles_air = [_location_opfor_x, _location_opfor_y] nearObjects ["Air", 100];
_csat_vehicles_air_num = 0;
{
	_csat_vehicles_air_num = _csat_vehicles_air_num + 1;
	_x setVariable ["BIS_enableRandomization", false];
	_csat_air_position = getPos _x;
	_x respawnVehicle [120, 0];
	[format ["Found %1 on %2", _x, _csat_air_position]] call WarZones_fnc_Debug;
	["--> Set air Respawn: 30 Seconds"] call WarZones_fnc_Debug;

	_csat_marker_string = Format ["respawn_vehicle_east_%1", str _csat_vehicles_air_num];
	createMarker [_csat_marker_string, position _x ];
	_csat_marker_string setMarkerAlpha 0.25;
	_csat_marker_string setMarkerType "respawn_armor";
	[format ["--> Air Respawn marker created: %1", _csat_marker_string]] call WarZones_fnc_Debug;

	// Pilot restriction
	_x addEventHandler ["GetIn",{
	        if (_this select 1 == "driver") then {
	            if (!((_this select 2) in pilots)) then {
	                _this select 2 action ["eject",_this select 0]; hint "You are not authorized to pilot this vehicle!";
	            };
			};
	        if (_this select 1 == "gunner") then {
	            if (!((_this select 2) in pilots)) then {
	                _this select 2 action ["eject",_this select 0]; hint "You are not authorized to pilot this vehicle!";
	            };
			};
		}
	];

	["--> Pilot restriction enabled"] call WarZones_fnc_Debug;

	sleep 0.1;
} forEach _csat_vehicles_air;