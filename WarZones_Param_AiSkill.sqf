/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_AiSkill.sqf
/  Description: This function sets the AI Skills, its called via description.ext.
/               The _param is the selected mission parameter (Class: Skill)
/
*/

_param = _this select 0;

switch (_param) do {
	case 1: {
		["Ai Skill: Easy"] call WarZones_fnc_Debug;
		{
			_x setSkill ["aimingspeed", 0.1];
			_x setSkill ["spotdistance", 0.2];
			_x setSkill ["aimingaccuracy", 0.1];
			_x setSkill ["aimingshake", 0.1];
			_x setSkill ["spottime", 0.1];
			_x setSkill ["spotdistance", 0.2];
			_x setSkill ["commanding", 0.5];
			_x setSkill ["general", 0.5];
		} forEach allUnits;
	};
	case 2: {
		["Ai Skill: Medium"] call WarZones_fnc_Debug;
		{
			_x setSkill ["aimingspeed", 0.3];
			_x setSkill ["spotdistance", 0.2];
			_x setSkill ["aimingaccuracy", 0.2];
			_x setSkill ["aimingshake", 0.60];
			_x setSkill ["spottime", 0.2];
			_x setSkill ["spotdistance", 0.5];
			_x setSkill ["commanding", 1];
			_x setSkill ["general", 0.8];
		} forEach allUnits;
	};

	case 3: {
		["Ai Skill: Hard"] call WarZones_fnc_Debug;
		{
			_x setSkill ["aimingspeed", 0.1];
			_x setSkill ["spotdistance", 0.2];
			_x setSkill ["aimingaccuracy", 0.2];
			_x setSkill ["aimingshake", 0.1];
			_x setSkill ["spottime", 0.1];
			_x setSkill ["spotdistance", 0.5];
			_x setSkill ["commanding", 0.2];
			_x setSkill ["general", 0.5];
		} forEach allUnits;
	};

	default {
		// Nothing
	};
};

["AI Skill has been set"] call WarZones_fnc_Debug;