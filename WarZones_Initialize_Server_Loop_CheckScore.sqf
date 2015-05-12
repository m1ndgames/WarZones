// WarZones_Initialize_Server_Loop_GearCheck.sqf
/////////////////////////////////////////////////////////////////////////////////////
[] spawn {
	scopeName "checkscore";
	while {true} do {
		[] call WarZones_fnc_CheckScore;
	};
	sleep 5;
};