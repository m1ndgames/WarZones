//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Creator    //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

_scr = [] spawn (compile preprocessFile "DAC\Scripts\DAC_Preprocess.sqf");
waituntil {scriptdone _scr};

scalar = "any";DAC_Init_Camps = 0;

waituntil{time > 0.3};

if(isServer) then {if(local player) then {DAC_Code = 1} else {DAC_Code = 0}} else {if(isnull player) then {DAC_Code = 3} else {DAC_Code = 2}};

//===============|
// DAC_Settings	 |
//===============|=============================================================================================|

	if(isNil "DAC_STRPlayers")		then {		DAC_STRPlayers		= ["blufor_player_1","blufor_player_2","blufor_player_3","blufor_player_4","blufor_player_5","blufor_player_6","blufor_player_7","blufor_player_8","blufor_player_9","blufor_player_10","blufor_player_11","blufor_player_12","blufor_player_13","blufor_player_14","blufor_player_15","blufor_player_16","blufor_player_17","blufor_player_18","blufor_player_19","blufor_player_20","blufor_player_21","blufor_player_22","blufor_player_23","blufor_player_24","blufor_player_25","blufor_player_26","blufor_player_27","blufor_player_28","blufor_player_29","blufor_player_30","blufor_player_31","blufor_player_32","opfor_player_1","opfor_player_2","opfor_player_3","opfor_player_4","opfor_player_5","opfor_player_6","opfor_player_7","opfor_player_8","opfor_player_9","opfor_player_10","opfor_player_11","opfor_player_12","opfor_player_13","opfor_player_14","opfor_player_15","opfor_player_16","opfor_player_17","opfor_player_18","opfor_player_19","opfor_player_20","opfor_player_21","opfor_player_22","opfor_player_23","opfor_player_24","opfor_player_25","opfor_player_26","opfor_player_27","opfor_player_28","opfor_player_29","opfor_player_30","opfor_player_31","opfor_player_32"]};
	if(isNil "DAC_AI_Count_Level")	then {		DAC_AI_Count_Level  = [[2,3],[3,6],[4,8],[6,12],[1,0]]			};
	if(isNil "DAC_Dyn_Weather") 	then {		DAC_Dyn_Weather		= [0,0,0,[0, 0, 0],0]						};
	if(isNil "DAC_Reduce_Value") 	then {		DAC_Reduce_Value	= [600,650,0]								};
	if(isNil "DAC_AI_Spawn") 		then {		DAC_AI_Spawn		= [[10,5,5],[10,5,15],0,120,250,0]			};
	if(isNil "DAC_Delete_Value") 	then {		DAC_Delete_Value	= [[180,50],[180,100],6000]				};
	if(isNil "DAC_Del_PlayerBody") 	then {		DAC_Del_PlayerBody	= [60,25]										};
	if(isNil "DAC_Com_Values") 		then {		DAC_Com_Values		= [1,2,3,1]									};
	if(isNil "DAC_AI_AddOn") 		then {		DAC_AI_AddOn		= 1											};
	if(isNil "DAC_AI_Level") 		then {		DAC_AI_Level		= 3											};
	if(isNil "DAC_Res_Side") 		then {		DAC_Res_Side		= 2											};
	if(isNil "DAC_Marker") 			then {		DAC_Marker			= 2											};
	if(isNil "DAC_WP_Speed") 		then {		DAC_WP_Speed		= 0.01										};
	if(isNil "DAC_Join_Action")		then {		DAC_Join_Action		= false										};
	if(isNil "DAC_Fast_Init") 		then {		DAC_Fast_Init		= false										};
	if(isNil "DAC_Player_Marker")	then {		DAC_Player_Marker	= true										};
	if(isNil "DAC_Direct_Start")	then {		DAC_Direct_Start	= false										};
	if(isNil "DAC_Activate_Sound")	then {		DAC_Activate_Sound	= false										};
	if(isNil "DAC_Auto_UnitCount")	then {		DAC_Auto_UnitCount	= [8,10]									};
	if(isNil "DAC_Player_Support")	then {		DAC_Player_Support	= [10,[4,2000,3,1000]]						};
	if(isNil "DAC_SaveDistance")	then {		DAC_SaveDistance	= [100,["base_blufor_flagpole","base_opfor_flagpole"]]				};
	if(isNil "DAC_Radio_Max")		then {		DAC_Radio_Max		= DAC_AI_Level								};

	DAC_BadBuildings 	= 	[];
	DAC_GunNotAllowed	= 	[];
	DAC_VehNotAllowed	= 	[];
	DAC_Locked_Veh		=	[];
	DAC_SP_Soldiers     =   ["B_soldier_AR_F","B_G_soldier_AR_F","O_soldier_AR_F","O_soldierU_AR_F","O_G_soldier_AR_F","I_soldier_AR_F","I_G_soldier_AR_F"];
	DAC_Data_Array 		= 	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,[]];
	DAC_Marker_Val		= 	[];
	DAC_Zones			=	[/*"aafzoneinf","aafzoneinfcamp","aafzonetank","aafzonetankcamp","aafzonemoto","aafzonemotocamp","aafzoneheli","aafzonehelicamp"*/];

	//=============================================================================================================|

	_scr = [] spawn (compile preprocessFile "DAC\Scripts\DAC_Start_Creator.sqf");
	waituntil {scriptdone _scr};
	sleep 0.1;
	waituntil {(DAC_Basic_Value > 0)};

if(DAC_Code < 2) then
{
	//===========================================|
	// StartScriptOnServer                       |
	//===========================================|
	//player sidechat "ServerStart"
	//[] execVM "myServerScript.sqf";
	//onMapSingleClick "_fun = [_pos,_shift]execVM ""Action.sqf""";
}
else
{
	if(DAC_Code == 3) then
	{
		//===========================================|
		// StartScriptOnJipClient                    |
		//===========================================|
		//player sidechat "JipClientStart"
		//[] execVM "myJipClientScript.sqf";
	}
	else
	{
		//===========================================|
		// StartScriptOnClient                       |
		//===========================================|
		//player sidechat "ClientStart"
		//[] execVM "myClientScript.sqf";
		//onMapSingleClick "_fun = [_pos,_shift]execVM ""Action.sqf""";
	};
};