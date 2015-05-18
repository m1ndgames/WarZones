_score = rating player;

if (_score < 500) then {
	player setUnitRank "PRIVATE";
};

if (_score > 500) then {
	if (_score < 1500) then {
		player setUnitRank "CORPORAL";
	};
};

if (_score > 1500) then {
	if (_score < 2500) then {
		player setUnitRank "SERGEANT";
	};
};

if (_score > 2500) then {
	if (_score < 3500) then {
		player setUnitRank "LIEUTENANT";
	};
};

if (_score > 3500) then {
	if (_score < 5000) then {
		player setUnitRank "CAPTAIN";
	};
};

if (_score > 5000) then {
	if (_score < 7500) then {
		player setUnitRank "MAJOR";
	};
};

if (_score > 7500) then {
	player setUnitRank "COLONEL";
};