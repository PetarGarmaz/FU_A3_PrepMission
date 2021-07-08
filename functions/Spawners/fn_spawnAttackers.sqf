_groupPos = _this param[0];
_side = _this param [1];
_type = _this param[2]; //0 - Squad; 1 - Fireteam; 2 - Techie; 3 - APC; 4 - Tank; 5 - Plane; 6 - Heli; 7 - QRF (Truck); 8 - QRF (Heli);
_objective = _this param [3];

_groupPos = [_groupPos, 700, 1000, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
_vehicleSpawn = [_groupPos, 2000, []] call BIS_fnc_nearestRoad;
_group = createGroup [_side, true];
_vehicle = objNull;
_squadComp = [];
_vehComp = [];

if(_side == west) then {
	_squadComp = ["rhsusf_army_ucp_teamleader", "rhsusf_army_ucp_medic","rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_maaws","rhsusf_army_ucp_teamleader","rhsusf_army_ucp_medic","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_maaws", "rhsusf_army_ucp_teamleader","rhsusf_army_ucp_medic","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_maaws"];
	_vehComp = ["rhsusf_m1025_w_m2", "rhsusf_stryker_m1126_m2_wd", "rhsusf_m1a2sep1tuskiiwd_usarmy", "RHS_UH60M", "RHS_A10", "rhsusf_M1078A1P2_WD_fmtv_usarmy"];
	
	if(_type == 0) then {
		for "_i" from 0 to 7 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
	};
	
	if(_type == 1) then {
		for "_i" from 0 to 3 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
	};

	if(_type == 2) then {
		_vehicle = createVehicle [(_vehComp select 0), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 3) then {
		_vehicle = createVehicle [(_vehComp select 1), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 4) then {
		_vehicle = createVehicle [(_vehComp select 2), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 5) then {
		_vehicle = createVehicle [(_vehComp select 3), _groupPos, [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 6) then {
		_vehicle = createVehicle [(_vehComp select 4), [(_groupPos select 0) + 5000, (_groupPos select 1) + 5000, 0], [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 7) then {
		_vehicle = createVehicle [(_vehComp select 5), _vehicleSpawn, [], 0, "NONE"];
		
		for "_i" from 0 to 11 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
		
		{
			_x moveInAny _vehicle;
		} foreach (units _group);
		
		_getOut = _group addWaypoint [_objective, 300];
		_getOut setWaypointType "GETOUT";
	};

	
};


if(_side == east) then {
	_squadComp = ["rhs_msv_emr_efreitor","rhs_msv_emr_medic","rhs_msv_emr_arifleman","rhs_msv_emr_at","rhs_msv_emr_efreitor","rhs_msv_emr_medic","rhs_msv_emr_rifleman","rhs_msv_emr_at","rhs_msv_emr_efreitor","rhs_msv_emr_medic","rhs_msv_emr_rifleman","rhs_msv_emr_at"];
	_vehComp = ["rhs_tigr_sts_msv", "rhs_btr80_msv", "rhs_t90sm_tv", "RHS_Mi8MTV3_vdv", "RHS_Su25SM_Cluster_vvsc", "rhs_gaz66_msv"];

	if(_type == 0) then {
		for "_i" from 0 to 7 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
	};
	
	if(_type == 1) then {
		for "_i" from 0 to 3 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
	};

	if(_type == 2) then {
		_vehicle = createVehicle [(_vehComp select 0), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 3) then {
		_vehicle = createVehicle [(_vehComp select 1), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 4) then {
		_vehicle = createVehicle [(_vehComp select 2), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 5) then {
		_vehicle = createVehicle [(_vehComp select 3), _groupPos, [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 6) then {
		_vehicle = createVehicle [(_vehComp select 4), [(_groupPos select 0) + 5000, (_groupPos select 1) + 5000, 0], [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 7) then {
		_vehicle = createVehicle [(_vehComp select 5), _vehicleSpawn, [], 0, "NONE"];
		
		for "_i" from 0 to 11 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
		
		{
			_x moveInAny _vehicle;
		} foreach (units _group);
		
		_getOut = _group addWaypoint [_objective, 300];
		_getOut setWaypointType "GETOUT";
	};
};


if(_side == resistance) then {
	_squadComp = ["LOP_PMC_Infantry_SL", "LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_MG","LOP_PMC_Infantry_AT","LOP_PMC_Infantry_TL","LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_Rifleman","LOP_PMC_Infantry_AT","LOP_PMC_Infantry_TL","LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_Rifleman","LOP_PMC_Infantry_AT"];
	_vehComp = ["LOP_PMC_Offroad_M2", "rhsgref_ins_g_btr60", "rhsgref_ins_g_t72ba", "LOP_PMC_MH9_armed", "rhs_l39_cdf", "LOP_PMC_Truck"];

	if(_type == 0) then {
		for "_i" from 0 to 7 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
	};
	
	if(_type == 1) then {
		for "_i" from 0 to 3 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
	};

	if(_type == 2) then {
		_vehicle = createVehicle [(_vehComp select 0), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 3) then {
		_vehicle = createVehicle [(_vehComp select 1), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 4) then {
		_vehicle = createVehicle [(_vehComp select 2), _vehicleSpawn, [], 0, "NONE"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 5) then {
		_vehicle = createVehicle [(_vehComp select 3), _groupPos, [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 6) then {
		_vehicle = createVehicle [(_vehComp select 4), [(_groupPos select 0) + 5000, (_groupPos select 1) + 5000, 0], [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};
	
	if(_type == 7) then {
		_vehicle = createVehicle [(_vehComp select 5), _vehicleSpawn, [], 0, "NONE"];
		
		for "_i" from 0 to 11 do {_man = _group createUnit [(_squadComp select _i), _groupPos, [], 0, "CAN_COLLIDE"];};
		
		{
			_x moveInAny _vehicle;
		} foreach (units _group);
		
		_getOut = _group addWaypoint [_objective, 300];
		_getOut setWaypointType "GETOUT";
	};
};

//Group logic
_move1 = _group addWaypoint [_objective, 0];
_move1 setWaypointType "MOVE";

_group setBehaviour "AWARE";
_group setCombatMode "RED";
_group setSpeedMode "FULL";
_group setFormation "DIAMOND";

//Add flashlights
{
	if(_side == east) then {
		removeAllPrimaryWeaponItems _x;
		_x addPrimaryWeaponItem "rhs_acc_2dpzenit";
		_x  enableGunLights "forceon";
	} else {
		removeAllPrimaryWeaponItems _x;
		_x addPrimaryWeaponItem "acc_flashlight";
		_x  enableGunLights "forceon";
	};
}forEach (units _group);