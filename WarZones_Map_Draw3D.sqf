// Draw3d Loop
////////////////////////////////////////////////////////////////////
// Get Spot Distance from Mission Parameters
//cfg_spot_distance_team = "SpotDistance" call BIS_fnc_getParamValue;

// Define Mission Root
_root = parsingNamespace getVariable "MISSION_ROOT";

{
	spot_spotted = _x;
	spot_distance = [player, spot_spotted] call BIS_fnc_distance2D;

	if (spot_distance < 250) then {
		spot_side_own = side (group player);
		spot_side_spotted = side (group spot_spotted);

		if (spot_side_own == spot_side_spotted) then {

			if (spot_side_own == blufor) then {
				spot_texture_color = [0,0,255,0.4];
			};
			if (spot_side_own == opfor) then {
				spot_texture_color = [255,0,0,0.4];

			} else {
				spot_texture_color = [255,255,255,1.0];
			};

			spot_Pos = getPosATL spot_spotted;
			spot_rank_short = [spot_spotted,"displayNameShort"] call BIS_fnc_rankParams;
			spot_rank = [spot_spotted,"classname"] call BIS_fnc_rankParams;

			if (spot_rank == "PRIVATE") then {
				spot_texture = (_root + "pics\markers_3d\Private.paa");
			};

			if (spot_rank == "CORPORAL") then {
				spot_texture = (_root + "pics\markers_3d\Corporal.paa");
			};

			if (spot_rank == "SERGEANT") then {
				spot_texture = (_root + "pics\markers_3d\Sergeant.paa");
			};

			if (spot_rank == "LIEUTENANT") then {
				spot_texture = (_root + "pics\markers_3d\Lieutenant.paa");
			};

			if (spot_rank == "CAPTAIN") then {
				spot_texture = (_root + "pics\markers_3d\Captain.paa");
			};

			if (spot_rank == "MAJOR") then {
				spot_texture = (_root + "pics\markers_3d\Major.paa");
			};

			if (spot_rank == "COLONEL") then {
				spot_texture = (_root + "pics\markers_3d\Colonel.paa");
			};

			if (spot_rank == "GENERAL") then {
				spot_texture = (_root + "pics\markers_3d\General.paa");
			};

			spot_string = format["%1 %2", spot_rank_short, name spot_spotted];

			drawIcon3D [
				spot_texture,
				spot_texture_color,
				[spot_Pos select 0,spot_Pos select 1,2.3],
				1,
				1,
				0,
				spot_string,
				0,
				0.025,
				"PuristaLight",
				"",
				false
			];
		};
	};
} forEach allUnits;