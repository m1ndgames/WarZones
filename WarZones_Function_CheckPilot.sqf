/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_CheckPilot.sqf
/  Description: Function that checks if a unit wears a pilot helmet and adds him to the pilots array.
/               It is called in a loop in File: WarZones_Initialize_Server_Loop_GearCheck.sqf
/
*/

if (headgear _this select 0 == "H_PilotHelmetFighter_B") exitWith {
		echo "ispilot";
};