_param = _this select 0;

switch (_param) do {
	case 50: {
		["Terrain Config: Low"] call WarZones_fnc_Debug;
		setTerrainGrid _param;
	};
	case 25: {
		["Terrain Config: Standart"] call WarZones_fnc_Debug;
		setTerrainGrid _param;
	};
	case 12.5: {
		["Terrain Config: High"] call WarZones_fnc_Debug;
		setTerrainGrid _param;
	};
	case 6.25: {
		["Terrain Config: Very High"] call WarZones_fnc_Debug;
		setTerrainGrid _param;
	};
	case 3.125: {
		["Terrain Config: Ultra"] call WarZones_fnc_Debug;
		setTerrainGrid _param;
	};
	default {
		// Nothing
	};
};