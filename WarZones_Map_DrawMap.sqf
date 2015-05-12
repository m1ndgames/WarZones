{
	map_draw_spotted = _x;
	map_draw_distance = [player, map_draw_spotted] call BIS_fnc_distance2D; // Get Distance from Player to _x
//	_getparam_MapRange = "MapRange" call BIS_fnc_getParamValue;

	map_draw_side_own = side (group player);
	map_draw_side_spotted = side (group map_draw_spotted);
	if (map_draw_side_own == map_draw_side_spotted) then {

		if (map_draw_distance < 5000) then { // Distance < 5000m
			map_draw_side_own = side (group player); // Get own Side

			if (map_draw_side_own == blufor) then { // Paint BLUFOR Blue
				map_draw_color = [0,0,255,1.0];
			};
			if (map_draw_side_own == opfor) then { // Paint OPFOR Red
				map_draw_color = [255,0,0,1.0];

			} else {
				map_draw_color = [255,255,255,1.0]; // Everything else is white
			};
			map_draw_Pos = getPosATL map_draw_spotted; // Get Position
			map_draw_rank_short = [map_draw_spotted,"displayNameShort"] call BIS_fnc_rankParams; // Get Short Rank of _x
			map_draw_string = format["%1 %2", map_draw_rank_short, name map_draw_spotted]; // Build a String of Shortrank + Playername
			disableSerialization; // Needed because of reasons
			_mapctrl = (findDisplay 12) displayCtrl 51;
			_mapctrl drawIcon [ // Find the map ctrl and draw the icon
				'iconMan', // The man!
				map_draw_color, // Team Color
				map_draw_Pos, // Position
				20, // x size
				20, // y size
				getDir map_draw_spotted, // Player direction
				map_draw_string, // The Shortname + Playername string
				1, // Shadow
				0.02, // Fontsize
				'TahomaB', // Font
				'right' // Font Align
			];
		};
	};
} forEach allUnits; // Do it for all living units