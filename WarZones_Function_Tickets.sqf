// Tickets Usage
// 		[add,side,1000] call WarZones_fnc_Tickets;
// 		_sidetickets = [read,side,nil] call WarZones_fnc_Tickets;

_param = _this select 0; // Can be add, read
_val1 = _this select 1; // Side
_val2 = _this select 2; // Value

switch (_param) do {
	case "add": {
		[_val1, _val2] call BIS_fnc_respawnTickets;
//		[_val1] call BIS_fnc_respawnTickets;
	};

	case "read": {
		[_val1] call BIS_fnc_respawnTickets;
	};

	default {
		// Nothing
	};
};