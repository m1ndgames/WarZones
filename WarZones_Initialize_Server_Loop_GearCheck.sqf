// WarZones_Initialize_Server_Loop_GearCheck.sqf
/////////////////////////////////////////////////////////////////////////////////////
[] spawn {
	{
		scopeName "gearcheck";
		while {true} do {
			[_x] call WarZones_fnc_GearCheck;
		};
	} forEach allUnits;
	sleep 5;
};