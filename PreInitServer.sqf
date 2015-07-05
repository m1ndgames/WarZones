/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: PreInitServer.sqf
/  Description: This init script is executed by server before the mission is started. (PreInit)
/
*/
if (!isServer) exitWith {};

<<<<<<< HEAD
////////////////////////////
=======
>>>>>>> de1852e4847c0b8b5bdc03dc95b643e36d753808
// Give Tickets to the Teams
[blufor, 250] call BIS_fnc_respawnTickets;
[opfor, 250] call BIS_fnc_respawnTickets;
[resistance, 100] call BIS_fnc_respawnTickets;
["Server: Gave tickets to the Teams"] call WarZones_fnc_Debug;

<<<<<<< HEAD
/////////////////////////////////////////////
=======
>>>>>>> de1852e4847c0b8b5bdc03dc95b643e36d753808
// Start Ticket Bleeding for the Player Teams
[[blufor,opfor], 0.5, 3, 5] call BIS_fnc_bleedTickets;
["Server: Ticket Bleeding initialized"] call WarZones_fnc_Debug;

<<<<<<< HEAD
/////////////////////////////////////
=======
// Initialize Mission-End Check
[] spawn WarZones_fnc_CheckWin;

>>>>>>> de1852e4847c0b8b5bdc03dc95b643e36d753808
// Initialize dynamic groups - Server
["Initialize"] call BIS_fnc_dynamicGroups;
["Initialized Dynamic Groups"] call WarZones_fnc_Debug;

///////////////////
// Disable NPC Talk
{
	_x disableConversation true;
} forEach AllUnits;
["Server: Disabled conversations"] call WarZones_fnc_debug;

//////////////////////////////////////
// Initialize Missionending-check-Loop
[] spawn {
	_sides = [ east, west ];

	// Wait for mission to start
	waitUntil {
	    time > 0
	};

	// Wait till one Team has run out of Tickets
	waitUntil {
	    {[ _x, 0 ] call BIS_fnc_respawnTickets <= 0; }
	    count _sides > 0;
	};

	// Get scores
	_scores = [ scoreSide east, scoreSide west ];

	// Find the highest score
	_highScore = ( _scores select 0 ) max ( _scores select 1 );

	// Find side that has the highest score
	_winner = _sides deleteAt ( _scores find _highScore );

	// End game for winners
	[ [ "Win", true, true ], "BIS_fnc_endMission", _winner ] call BIS_fnc_MP;

	// End game for losers
	[ [ "Lose", false, 5 ], "BIS_fnc_endMission", _sides select 0 ] call BIS_fnc_MP;
};

/////////////////////////////////
// End of File: PreInitServer.sqf
