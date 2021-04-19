_supplier = _this param [0];

missionNamespace setVariable ["supplyMenu", true, true];
missionNamespace setVariable ["supplyRequestee", objNull, true];

_supplier addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa'/> Request Supplies", {
	[(_this select 0), format ["Hello, %1! What can I do for you?", name (_this select 1)]] remoteExec ["sideChat", 0];

	missionNamespace setVariable ["supplyMenu", false, true];
	missionNamespace setVariable ["supplyRequestee", (_this select 1), true];

	sleep 10;
	
	if(not(missionNamespace getVariable 'supplyMenu')) then {
		missionNamespace setVariable ["supplyRequestee", objNull, true];
		missionNamespace setVariable ["supplyMenu", true, true];
	};
	
}, nil, 1.5, true, true, "", "(missionNamespace getVariable 'supplyMenu') && (missionNamespace getVariable 'recruitmentMenu') && (side _this == side _target)", 3];

_supplier addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\A_ca.paa'/> Request a Repair/Vehicle Ammo Box", {
	[(_this select 1), "One Vehicle Ammo Box, please!"] remoteExec ["sideChat", 0];
	sleep 2;
	[side (_this select 1), 0, (_this select 0), (_this select 1)] spawn Bizo_fnc_spawnSupplies;
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'supplyMenu') && (_this == (missionNamespace getVariable 'supplyRequestee'))", 3];

_supplier addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\B_ca.paa'/> Request an Ammo Box", {
	[(_this select 1), "One Ammo Box, please!"] remoteExec ["sideChat", 0];
	sleep 2;
	[side (_this select 1), 1, (_this select 0), (_this select 1)] spawn Bizo_fnc_spawnSupplies;
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'supplyMenu') && (_this == (missionNamespace getVariable 'supplyRequestee'))", 3];

_supplier addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\C_ca.paa'/> Request a Medical Crate", {
	[(_this select 1), "One Medical Crate, please!"] remoteExec ["sideChat", 0];
	sleep 2;
	[side (_this select 1), 2, (_this select 0), (_this select 1)] spawn Bizo_fnc_spawnSupplies;
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'supplyMenu') && (_this == (missionNamespace getVariable 'supplyRequestee'))", 3];

_supplier addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa'/> Request a Fuel Cargo Net", {
	[(_this select 1), "One Fuel Cargo Net, please!"] remoteExec ["sideChat", 0];
	sleep 2;
	[side (_this select 1), 3, (_this select 0), (_this select 1)] spawn Bizo_fnc_spawnSupplies;
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'supplyMenu') && (_this == (missionNamespace getVariable 'supplyRequestee'))", 3];

_supplier addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\X_ca.paa'/> Go back", {
	[(_this select 1), "Nevermind..."] remoteExec ["sideChat", 0];
	missionNamespace setVariable ["supplyMenu", true, true];
	missionNamespace setVariable ["supplyRequestee", objNull, true];
}, nil, 1.5, true, true, "", "not(missionNamespace getVariable 'supplyMenu') && (side _this == side _target)", 3];

