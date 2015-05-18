// WarZones_Initialize_Server_Loop_CheckGear.sqf
/////////////////////////////////////////////////////////////////////////////////////
[] spawn {
	{
		scopeName "CheckGear";
		while {true} do {
			[_x] call WarZones_fnc_CheckGear;
		};
	} forEach allUnits;
	sleep 5;
};