/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: PreInitClient.sqf
/  Description: This init script is executed by Players before the mission is started. (PreInit)
/
*/
if (isServer) exitWith {};

if (!isServer) then {
    if (!isNumber (missionConfigFile >> "briefing")) exitWith {};
    if (getNumber (missionConfigFile >> "briefing") == 1) exitWith {};
    0 = [] spawn {
        waitUntil {
            if (getClientState == "BRIEFING READ") exitWith {true};
            if (!isNull findDisplay 53) exitWith {
                ctrlActivate (findDisplay 53 displayCtrl 1);
                findDisplay 53 closeDisplay 1;
                true
            };
            false
        };
    };
};

// Initialize dynamic groups - Client
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
["Initialized Dynamic Groups"] call WarZones_fnc_Debug;

// End of File: PreInitClient.sqf