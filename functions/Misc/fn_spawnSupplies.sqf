_side = _this param [0];
_type = _this param [1]; //0 - Vehicle ammo; 1 - Infantry ammo; 2 - Medical supplies; 3 - Fuel;
_giver = _this param [2];
_requestee = _this param [3];
_isRecruiting = _this param [4, false];

_spawnPos = [];
_supplyBox = [];
_squadComp = [];

if(_isRecruiting)then {
	_group = group _requestee;

	if(_side == west) then {
		_squadComp = ["rhsusf_army_ucp_medic","rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_maaws","rhsusf_army_ucp_teamleader","rhsusf_army_ucp_medic","rhsusf_army_ucp_marksman","rhsusf_army_ucp_maaws"];
		_spawnPos = getMarkerPos "respawn_west";
		
		if(_type == 0) then {
			for "_i" from 0 to 6 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
		
		if(_type == 1) then {
			for "_i" from 0 to 2 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
		
		if(_type == 2) then {
			for "_i" from 0 to 0 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
	};
	
	if(_side == east) then {
		_squadComp = ["rhs_msv_emr_medic","rhs_msv_emr_arifleman","rhs_msv_emr_at","rhs_msv_emr_efreitor","rhs_msv_emr_medic","rhs_msv_emr_marksman","rhs_msv_emr_at"];
		_spawnPos = getMarkerPos "respawn_east";
		
		if(_type == 0) then {
			for "_i" from 0 to 6 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
		
		if(_type == 1) then {
			for "_i" from 0 to 2 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
		
		if(_type == 2) then {
			for "_i" from 0 to 0 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
	};
	
	if(_side == resistance) then {
		_squadComp = ["LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_MG","LOP_PMC_Infantry_AT","LOP_PMC_Infantry_TL","LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_Marksman","LOP_PMC_Infantry_AT"];
		_spawnPos = getMarkerPos "respawn_guerrila";
		
		if(_type == 0) then {
			for "_i" from 0 to 6 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
		
		if(_type == 1) then {
			for "_i" from 0 to 2 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
		
		if(_type == 2) then {
			for "_i" from 0 to 0 do {_man = _group createUnit [(_squadComp select _i), _spawnPos, [], 0, "CAN_COLLIDE"];};
		};
	};
	
	[_giver, "Okay, your recruit/s is/are waiting for you outside! [Near player spawn]"] remoteExec ["sideChat", 0];
}
else {
	if(_side == west) then {
		_spawnPos = getMarkerPos "respawn_west";

		if(_type == 0) then {_supplyBox = "Box_NATO_AmmoVeh_F" createVehicle (_spawnPos); _supplyBox setVariable ["ACE_isRepairVehicle", true, true];};
		if(_type == 1) then {_supplyBox = "Box_NATO_Ammo_F" createVehicle (_spawnPos);};
		if(_type == 2) then {_supplyBox = "ACE_medicalSupplyCrate_advanced" createVehicle (_spawnPos);};
		if(_type == 3) then {_supplyBox = "CargoNet_01_barrels_F" createVehicle (_spawnPos); [_supplyBox, 1000] remoteExecCall ["ace_refuel_fnc_makeSource", 2];};
	};

	if(_side == east) then {
		_spawnPos = getMarkerPos "respawn_east";

		if(_type == 0) then {_supplyBox = "Box_NATO_AmmoVeh_F" createVehicle (_spawnPos); _supplyBox setVariable ["ACE_isRepairVehicle", true, true];};
		if(_type == 1) then {_supplyBox = "Box_East_Ammo_F" createVehicle (_spawnPos);};
		if(_type == 2) then {_supplyBox = "ACE_medicalSupplyCrate_advanced" createVehicle (_spawnPos);};
		if(_type == 3) then {_supplyBox = "CargoNet_01_barrels_F" createVehicle (_spawnPos); [_supplyBox, 1000] remoteExecCall ["ace_refuel_fnc_makeSource", 2];};
	};

	if(_side == resistance) then {
		_spawnPos = getMarkerPos "respawn_guerrila";

		if(_type == 0) then {_supplyBox = "Box_NATO_AmmoVeh_F" createVehicle (_spawnPos); _supplyBox setVariable ["ACE_isRepairVehicle", true, true];};
		if(_type == 1) then {_supplyBox = "Box_IND_Ammo_F" createVehicle (_spawnPos);};
		if(_type == 2) then {_supplyBox = "ACE_medicalSupplyCrate_advanced" createVehicle (_spawnPos);};
		if(_type == 3) then {_supplyBox = "CargoNet_01_barrels_F" createVehicle (_spawnPos); [_supplyBox, 1000] remoteExecCall ["ace_refuel_fnc_makeSource", 2];};
	};
	
	[_giver, "Okay, your supplies are waiting for you outside! [Near player spawn]"] remoteExec ["sideChat", 0];
};


missionNamespace setVariable ["recruitmentMenu", true, true];
missionNamespace setVariable ["recruitmentRequestee", objNull, true];

missionNamespace setVariable ["supplyMenu", true, true];
missionNamespace setVariable ["supplyRequestee", objNull, true];