/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_TerrainConfig.sqf
/  Description: This function sets the Terrain config according to the mission params.
/
*/

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