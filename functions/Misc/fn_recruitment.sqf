_recruiter = _this param [0];

missionNamespace setVariable ["recruitmentMenu", true, true];
missionNamespace setVariable ["recruitmentRequestee", objNull, true];

_recruiter addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa'/> Recruit Personnel", {
	[(_this select 0), format ["Hello, %1! What can I do for you?", name (_this select 1)]] remoteExec ["sideChat", 0];

	missionNamespace setVariable ["recruitmentMenu", false, true];
	missionNamespace setVariable ["recruitmentRequestee", (_this select 1), true];
	
	sleep 10;
	
	if(not(missionNamespace getVariable 'recruitmentMenu')) then {
		missionNamespace setVariable ["recruitmentRequestee", objNull, true];
		missionNamespace setVariable ["recruitmentMenu", true, true];
	};
}, nil, 1.5, true, true, "", "(missionNamespace getVariable 'recruitmentMenu') && (missionNamespace getVariable 'supplyMenu') && (side _this == side _target)", 3];

_recruiter addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\A_ca.paa'/> Recruit a Squad", {
	[(_this select 1), "One Squad, please!"] remoteExec ["sideChat", 0];
	sleep 2;

	[side (_this select 1), 0, (_this select 0), (_this select 1), true] spawn Bizo_fnc_spawnSupplies;
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'recruitmentMenu') && (_this == (missionNamespace getVariable 'recruitmentRequestee'))", 3];

_recruiter addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\B_ca.paa'/> Recruit a Fireteam", {
	[(_this select 1), "One Fireteam, please!"] remoteExec ["sideChat", 0];
	sleep 2;
	
	[side (_this select 1), 1, (_this select 0), (_this select 1), true] spawn Bizo_fnc_spawnSupplies;
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'recruitmentMenu') && (_this == (missionNamespace getVariable 'recruitmentRequestee'))", 3];

_recruiter addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\C_ca.paa'/> Recruit a Rifleman", {
	[(_this select 1), "One Rifleman, please!"] remoteExec ["sideChat", 0];
	sleep 2;
	
	[side (_this select 1), 2, (_this select 0), (_this select 1), true] spawn Bizo_fnc_spawnSupplies;
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'recruitmentMenu') && (_this == (missionNamespace getVariable 'recruitmentRequestee'))", 3];

_recruiter addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\X_ca.paa'/> Go back", {
	[(_this select 1), "Nevermind..."] remoteExec ["sideChat", 0];
	missionNamespace setVariable ["recruitmentMenu", true, true];
	missionNamespace setVariable ["recruitmentRequestee", objNull, true];
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'recruitmentMenu') && (side _this == side _target)", 3];

