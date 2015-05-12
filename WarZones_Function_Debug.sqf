/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_Debug.sqf
/  Description: Function handles Debug Messages to the Logfile or Systemchat
/
*/

// [input] call WarZones_fnc_Debug;
_input = _this select 0;

diag_log text format["----> WarZones Debug:  %1", _input];