{
	if ((alive _x) && (isPlayer _x)) then {
		_score = rating _x;

		if (_score < 500) then {
			_x setUnitRank "PRIVATE";
		};

		if (_score > 500) then {
			if (_score < 1500) then {
				_x setUnitRank "CORPORAL";
			};
		};

		if (_score > 1500) then {
			if (_score < 2500) then {
				_x setUnitRank "SERGEANT";
			};
		};

		if (_score > 2500) then {
			if (_score < 3500) then {
				_x setUnitRank "LIEUTENANT";
			};
		};

		if (_score > 3500) then {
			if (_score < 5000) then {
				_x setUnitRank "CAPTAIN";
			};
		};

		if (_score > 5000) then {
			if (_score < 7500) then {
				_x setUnitRank "MAJOR";
			};
		};

		if (_score > 7500) then {
			_x setUnitRank "COLONEL";
		};
	};
} forEach allUnits;