/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_Debug.sqf
/  Description: Function handles Debug Messages to the Logfile or Systemchat
/
*/

_input = _this select 0;

// Show Debug messages?
usedebug = "yes";

// RPT Logfile
debug2log = "yes";

// Show as hint
debug2hint = "no";

// Show in Global Chat
debug2global = "yes";

if (usedebug == "yes") then {
	if (debug2log == "yes") then {
		diag_log text format["----> WarZones Debug:  %1", _input];
	};

	if (debug2hint == "yes") then {
		hint format["----> WarZones Debug:  %1", _input];
	};

	if (debug2global == "yes") then {
		player globalChat format["----> WarZones Debug:  %1", _input];
	};
};