// =========================================================================================================
// BAS f - noTeamKill                                                                                       
// Version: 0-5-0 (2007-01-08)                                                                              
// Author: Kronzky (www.kronzky.info / kronzky@gmail.com)                                                   
// =========================================================================================================
//
//  Immediately punishes an illegal kill or injury by applying the same level of injury                     
//  to the shooter as the victim received.                                                                  
//  (e.g. If the victim is only injured, the shooter will incur an injury.                                  
//  If the victim is killed, the shooter will die as well)                                                  
//
//  A weapons blow-back is simulated to make the self-injury seem somewhat plausible.                       
//
//  The effect works with team-kills caused by guns, grenades and satchels.                                 
//  It does not work if victim is run over with a vehicle.                                                  
//
// =========================================================================================================
//
//  Call syntax: x=[] execVM "noTeamKill.sqf"                                                                     
//
//  By default, only team members are protected.                                                            
//  If you want to protect team members AND civilians call the script with x=["TC"] execVM "noTeamKill.sqf".      
//  If you want to protect ONLY civilians call the script with x=["C"] execVM "noTeamKill.sqf".                   
//
//  If the function is called with the parameter "NOBOOM", (e.g. x=["C","NOBOOM"] execVM "noTeamKill.sqf")                       
//  there will be no "blow-back" explosion.
//
//  If the function is called with the parameter "DISARM",  (e.g. x=["TC","DISARM"] execVM "noTeamKill.sqf")                                                                      
//  the shooter will also lose his weapon upon a TK violation.  
//
//  If the function is called with the parameter "NODAM",  (e.g. x=["TC","NODAM"] execVM "noTeamKill.sqf")                                                                      
//  the shooter will not receive damage to himself (the blow-back explosion will also be disabled).  
//
//  If the function is called with the parameter "NOMSG", (e.g. x=["NOBOOM","NOMSG"] execVM "noTeamKill.sqf")                       
//  the will be no hint message when a team killer is penalized.
//
//  Requires a Game Logic named "BAS_Server_Logic" to work.
//
// =========================================================================================================

// is script called from server?
_init=false;
if ((local BAS_Server_Logic) || (isNull player)) then {_init=true};

_abort=false;
// in case variable hasn't been defined
if (isNil ("f_var_debugMode")) then {f_var_debugMode=0};
// switch not implemented yet
f_var_noTeamKill=true;
//if (isNil ("f_var_noTeamKill")) then {f_var_noTeamKill=false; _init=false; _abort=true};

_allTKUnits=[];
// if it's a player joining (JIP), then only protect him
if (!_init && !_abort) then
{
	_unit = player;
	if (f_var_debugMode==1) then {hint format["JIP:%1",_unit]};
		_allTKUnits = [_unit];
};


//  handle the different reactions to violations
	_msg = "hint format [""%1!"",localize ""STR_f_NOTK_Message""];";
	if (((_this find "NOMSG")!=-1) || ((_this find "nomsg")!=-1)) then { _msg = ""; };
	_boom = """G_30mm_HE"" createvehicle [getpos _u select 0, getpos _u select 1, _z];";
	if (((_this find "NOBOOM")!=-1) || ((_this find "noboom")!=-1)) then { _boom = ""; };
	_disarm = "";
	if (((_this find "DISARM")!=-1) || ((_this find "disarm")!=-1)) then { _disarm = "removeallweapons _u;"; };
	_damage = "_u setdamage _d";
	if (((_this find "NODAM")!=-1) || ((_this find "nodam")!=-1)) then { _damage = ""; _boom = ""};
	
	call compile format["BAS_PENALTY = {private['_u','_b','_d','_z']; _u=_this select 0; _b=_this select 1; _d=_this select 2; _z=-10+_b*5; %1; %2; %3; %4};",_msg,_boom,_disarm,_damage];

	BAS_prot = "";
	// determine protection scope
	if (((_this find "TC")!=-1) || ((_this find "tc")!=-1) || ((_this find "CT")!=-1) || ((_this find "ct")!=-1)) then {BAS_prot="TC";};
	if (((_this find "C")!=-1) || ((_this find "c")!=-1)) then {BAS_prot="C";};

if (_init) then
{
	// find all relevant units on the map (via temporary, large trigger)
	_trg = createTrigger ["EmptyDetector", [5000, 5000, 0]];
	if (BAS_prot=="C") then 
	{
		_trg setTriggerActivation ["CIV", "PRESENT", true];
	} else {
		_trg setTriggerActivation ["ANY", "PRESENT", true];
	};
	_trg setTriggerArea [20000, 20000, 0, false];
	_trg setTriggerStatements ["this", "", ""];
	sleep 1;
	BAS_allTKUnits = list _trg;
	sleep .1;
	_allTKUnits = BAS_allTKUnits;
	if (f_var_debugMode==1) then {hint format ["server:%1=%2\n%3:%4",BAS_prot,_allTKUnits,player,(local BAS_Server_Logic)]};
	// remove the trigger
	deletevehicle _trg;
};

// assign event handlers for being hit and being killed
{
	if ("Man" countType [_x]>0) then 
	{
		if ((BAS_prot == "TC") || (BAS_prot == "C")) then 
		{
			if (f_var_debugMode==1) then {player sidechat format["%1 (%2) hit protection (%3)",_x,name _x,BAS_prot]};
			_x addEventHandler ["hit", {_k=_this select 1; if (f_var_noTeamKill && isPlayer _k) then {_v=_this select 0; if ((_v!=_k) && ((side _v==civilian) || (side _v==side _k))) then {[_k,0,(damage _k + damage _v)] call BAS_PENALTY}}}];
		} else {
			if (f_var_debugMode==1) then {player sidechat format["%1 (%2) hit protection (%3)",_x,name _x,BAS_prot]};
			_x addEventHandler ["hit", {_k=_this select 1; if (f_var_noTeamKill && isPlayer _k) then {_v=_this select 0; if ((_v!=_k) && (side _v==side _k)) then {[_k,0,(damage _k + damage _v)] call BAS_PENALTY}}}];
		};
	
		_side = side _x;
		switch (_side) do
		{
			case civilian:
			{
				if ((BAS_prot == "TC") || (BAS_prot == "C")) then 
				{
					if (f_var_debugMode==1) then {player sidechat format["%1 (c:%2) kill protection (%3)",_x,name _x,BAS_prot]};
					_x addEventHandler ["killed", {_k=_this select 1; if (f_var_noTeamKill && isPlayer _k) then {_v=_this select 0; if (_v!=_k) then {[_k,1,1] call BAS_PENALTY}}}];
				} else {
					if (f_var_debugMode==1) then {player sidechat format["%1 (c:%2) kill protection (%3)",_x,name _x,BAS_prot]};
					_x addEventHandler ["killed", {_k=_this select 1; if (f_var_noTeamKill && isPlayer _k) then {_v=_this select 0; if ((_v!=_k) && (side _k==civilian)) then {[_k,1,1] call BAS_PENALTY}}}];
				};
			};
			case east:
			{
				if (f_var_debugMode==1) then {player sidechat format["%1 (e:%2) kill protection (%3)",_x,name _x,BAS_prot]};
				_x addEventHandler ["killed", {_k=_this select 1; if (f_var_noTeamKill && isPlayer _k) then {_v=_this select 0; if ((_v!=_k) && (side _k==east)) then {[_k,1,1] call BAS_PENALTY}}}];
			};
			case west:
			{
				if (f_var_debugMode==1) then {player sidechat format["%1 (w:%2) kill protection (%3)",_x,name _x,BAS_prot]};
				_x addEventHandler ["killed", {_k=_this select 1; if (f_var_noTeamKill && isPlayer _k) then {_v=_this select 0; if ((_v!=_k) && (side _k==west)) then {[_k,1,1] call BAS_PENALTY}}}];
			};
			case resistance:
			{
				if (f_var_debugMode==1) then {player sidechat format["%1 (r:%2) kill protection (%3)",_x,name _x,BAS_prot]};
				_x addEventHandler ["killed", {_k=_this select 1; if (f_var_noTeamKill && isPlayer _k) then {_v=_this select 0; if ((_v!=_k) && (side _k==resistance)) then {[_k,1,1] call BAS_PENALTY}}}];
			};
		};
	};
} forEach _allTKUnits;

