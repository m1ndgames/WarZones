/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: init.sqf
/  Description: This init script is executed by everyone when the mission is started. (Before briefing screen)
/
*/

//run on dedicated server only
if (isDedicated) then {
};

//run on dedicated server or player host
if (isServer) then {
};

//run on all player clients incl. player host
if (hasInterface) then {
};

//run on all player clients incl. player host and headless clients
if (!isDedicated) then {
};

//run on all player clients incl. headless clients but not player host
if (!isServer) then {
};

//run on headless clients and dedicated server
if (!hasInterface) then {
};

//run on headless clients only
if (!hasInterface && !isDedicated) then {
};

<<<<<<< HEAD
// End of File: init.sqf
=======
if(!isServer) then {waitUntil{!isNull player}};

DAC_Zone = compile preprocessFile "DAC\Scripts\DAC_Init_Zone.sqf";
DAC_Objects = compile preprocessFile "DAC\Scripts\DAC_Create_Objects.sqf";
execVM "DAC\DAC_Config_Creator.sqf";
>>>>>>> de1852e4847c0b8b5bdc03dc95b643e36d753808
