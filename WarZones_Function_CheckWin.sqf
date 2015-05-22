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

//Get scores
_scores = [ scoreSide east, scoreSide west ];

//Find the highest score
_highScore = ( _scores select 0 ) max ( _scores select 1 );

//Find side that has the highest score
_winner = _sides deleteAt ( _scores find _highScore );

//End game for winners
[ [ "Win", true, true ], "BIS_fnc_endMission", _winner ] call BIS_fnc_MP;

//End game for losers
[ [ "Lose", false, 5 ], "BIS_fnc_endMission", _sides select 0 ] call BIS_fnc_MP;