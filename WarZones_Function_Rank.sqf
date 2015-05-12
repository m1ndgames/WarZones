_param = _this select 0; // Can be get, set
_val1 = _this select 1; // Can be displayname, shortname, classname, texture, player
_val2 = _this select 1; // Player/Rank Classname/Rank ID

switch (_param) do {

	case "set": {
		_val1 setUnitRank _val2;
	};

	case "get": {
		switch (_val1) do {
			case "fullname": {
				[_val2,"displayName"] call BIS_fnc_rankParams;
			};
			case "shortname": {
				[_val2,"displayNameShort"] call BIS_fnc_rankParams;
			};
			case "classname": {
				[_val2,"classname"] call BIS_fnc_rankParams;
			};
			case "texture": {
				[_val2,"texture"] call BIS_fnc_rankParams;
			};
		default {
				// Nothing
			};
		};

	default {
		// Nothing
	};
};