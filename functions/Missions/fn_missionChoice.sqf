_missionGiver = _this param [0];

missionNamespace setVariable ["missionMenu", true, true];

missionNamespace setVariable ["missionAttack", false, true];
missionNamespace setVariable ["missionCAP", false, true];
missionNamespace setVariable ["missionHeli", false, true];
missionNamespace setVariable ["missionAssassination", false, true];

missionNamespace setVariable ["missionRequestee", objNull, true];

_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa'/> Request Mission", {
	[(_this select 0), format["Greetings, %1! Are you ready for your assignment, yet?", name (_this select 1)]] remoteExec ["sideChat", 0];
	
	missionNamespace setVariable ["missionMenu", false, true];
	missionNamespace setVariable ["missionRequestee", (_this select 1), true];
	
	sleep 10;
	
	if(not(missionNamespace getVariable 'missionMenu') && not(missionNamespace getVariable 'missionAttack') && not(missionNamespace getVariable 'missionCAP')) then {
		missionNamespace setVariable ["missionRequestee", objNull, true];
		missionNamespace setVariable ["missionMenu", true, true];
	};
}, nil, 1.5, true, true, "", "(missionNamespace getVariable 'missionMenu') && (side _this == side _target)", 3];



_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\attack_ca.paa'/> [MAIN MISSION] Attack Mission", {
	[(_this select 0), (_this select 1)] remoteExec ["Bizo_fnc_missionAttack", 2];
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'missionMenu') && not(missionNamespace getVariable 'missionAttack') && (_this == (missionNamespace getVariable 'missionRequestee'))", 3];

_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\plane_ca.paa'/> [SIDE MISSION] Combat Air Patrol (CAP)", {
	[(_this select 0), (_this select 1)] remoteExec ["Bizo_fnc_missionCAP", 2];
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'missionMenu') && not(missionNamespace getVariable 'missionCAP') && (_this == (missionNamespace getVariable 'missionRequestee'))", 3];

//_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa'/> [SIDE MISSION] Helicopter Mission (CAS/Transport) - Not available yet", {
//	hint "";
//}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'missionMenu') && not(missionNamespace getVariable 'missionHeli') && (_this == (missionNamespace getVariable 'missionRequestee'))", 3];

_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\kill_ca.paa'/> [SIDE MISSION] Assassinate Enemy Officer", {
	[(_this select 0), (_this select 1)] remoteExec ["Bizo_fnc_missionAssassination", 2];
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'missionMenu') && not(missionNamespace getVariable 'missionAssassination') && (_this == (missionNamespace getVariable 'missionRequestee'))", 3];

_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\X_ca.paa'/> [EXIT] Go back", {
	[(_this select 1), "Nevermind..."] remoteExec ["sideChat", 0];
	missionNamespace setVariable ["missionMenu", true, true];
	missionNamespace setVariable ["missionRequestee", objNull, true];
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'missionMenu') && (side _this == side _target)", 3];



_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa'/> Promote to Engineer", { 
	(_this select 1) setVariable ["ACE_IsEngineer", 2]; 
}, nil, 1.5, true, true, "", "(missionNamespace getVariable 'missionMenu') && (side _this == side _target)", 3];

_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa'/> Promote to Medic", { 
	(_this select 1) setVariable ["ACE_ace_medical_medicclass", 2]; 
}, nil, 1.5, true, true, "", "(missionNamespace getVariable 'missionMenu') && (side _this == side _target)", 3];

_missionGiver addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa'/> Promote to Platoon Leader", { 
	(_this select 1) setVehicleVarName format["PL_%1", str side (_this select 1)];
	
	if(side (_this select 1) == west) then {PL_WEST = (_this select 1)};
	if(side (_this select 1) == east) then {PL_EAST = (_this select 1)};
	if(side (_this select 1) == resistance) then {PL_GUER = (_this select 1)};
}, nil, 1.5, true, true, "", "(missionNamespace getVariable 'missionMenu') && (side _this == side _target)", 3];

