/* WarZones - A dynamic Mission for Arma 3
/
/  For more information visit https://github.com/m1ndgames/WarZones/
/
/  File: WarZones_Function_DB_CheckPlayer.sqf
/  Description: Function checks if joined player has stored Data, if its a new player it creates the initial table for that player.
/               It is called via PlayerConnected handler: WarZones_Handler_PlayerConnected.sqf
/
/  Not working!
/
*/

if (!isServer) exitWith {};
_playeruid = _this select 0; // Player UID