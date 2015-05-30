// Draw3d Loop
////////////////////////////////////////////////////////////////////
// Get Spot Distance from Mission Parameters
//cfg_spot_distance_team = "SpotDistance" call BIS_fnc_getParamValue;

// Define Mission Root
_root = parsingNamespace getVariable "MISSION_ROOT";


{
	spot_spotted = _x;
	spot_distance = [player, spot_spotted] call BIS_fnc_distance2D;

	if (spot_distance < 100) then {
		spot_side_own = side (group player);
		spot_side_spotted = side (group spot_spotted);

		if (spot_side_own == spot_side_spotted) then {
			if (name player == name spot_spotted) then {
				// Nothing
			} else {
/*				if ((spot_distance < 100) and (spot_distance > 90)) then {
					spot_texture_color = [255,255,255,0.1];
				};

				if ((spot_distance < 90) and (spot_distance > 80)) then {
					spot_texture_color = [255,255,255,0.2];
				};

				if ((spot_distance < 80) and (spot_distance > 70)) then {
					spot_texture_color = [255,255,255,0.3];
				};

				if ((spot_distance < 70) and (spot_distance > 60)) then {
					spot_texture_color = [255,255,255,0.4];
				};

				if ((spot_distance < 60) and (spot_distance > 50)) then {
					spot_texture_color = [255,255,255,0.5];
				};

				if ((spot_distance < 50) and (spot_distance > 40)) then {
					spot_texture_color = [255,255,255,0.6];
				};

				if ((spot_distance < 40) and (spot_distance > 30)) then {
					spot_texture_color = [255,255,255,0.7];
				};

				if ((spot_distance < 30) and (spot_distance > 20)) then {
					spot_texture_color = [255,255,255,0.8];
				};

				if ((spot_distance < 20) and (spot_distance > 10)) then {
					spot_texture_color = [255,255,255,0.9];
				};

				if (spot_distance < 10) then {
					spot_texture_color = [255,255,255,1.0];
				};
*/
				spot_texture_color = [255,255,255,0.6];

				spot_Pos = getPosATL spot_spotted;
				spot_rank_short = [spot_spotted,"displayNameShort"] call BIS_fnc_rankParams;
				spot_rank = [spot_spotted,"classname"] call BIS_fnc_rankParams;

				if (spot_rank == "PRIVATE") then {
					spot_texture = (_root + "pics\markers_3d\private.paa");
				};

				if (spot_rank == "CORPORAL") then {
					spot_texture = (_root + "pics\markers_3d\corporal.paa");
				};

				if (spot_rank == "SERGEANT") then {
					spot_texture = (_root + "pics\markers_3d\sergeant.paa");
				};

				if (spot_rank == "LIEUTENANT") then {
					spot_texture = (_root + "pics\markers_3d\lieutenant.paa");
				};

				if (spot_rank == "CAPTAIN") then {
					spot_texture = (_root + "pics\markers_3d\captain.paa");
				};

				if (spot_rank == "MAJOR") then {
					spot_texture = (_root + "pics\markers_3d\major.paa");
				};

				if (spot_rank == "COLONEL") then {
					spot_texture = (_root + "pics\markers_3d\colonel.paa");
				};

				if (spot_rank == "GENERAL") then {
					spot_texture = (_root + "pics\markers_3d\general.paa");
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
					"center",
					false
				];
			};
		};
	};
} forEach allUnits;