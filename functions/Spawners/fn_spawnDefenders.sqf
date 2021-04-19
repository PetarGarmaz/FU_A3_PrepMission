_groupPos = _this param[0];
_side = _this param [1];
_type = _this param[2]; //0 - Squad; 1 - Fireteam; 2 - Techie; 3 - APC; 4 - Tank; 5 - Heli; 6 - Plane;

_groupPos = [_groupPos, 10, 200, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
_vehicleSpawn = [_groupPos, 200, []] call BIS_fnc_nearestRoad;
_group = createGroup _side;
_vehicle = objNull;
_squadComp = [];
_vehComp = [];

if(_side == west) then {
	_squadComp = ["rhsusf_army_ucp_teamleader", "rhsusf_army_ucp_medic","rhsusf_army_ucp_autorifleman","rhsusf_army_ucp_maaws","rhsusf_army_ucp_teamleader","rhsusf_army_ucp_medic","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_maaws"];
	_vehComp = ["rhsusf_m1025_w_m2", "rhsusf_stryker_m1126_m2_wd", "rhsusf_m1a2sep1tuskiiwd_usarmy", "RHS_UH60M", "RHS_A10"];
	
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
		_vehicle = createVehicle [(_vehComp select 4), _groupPos, [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};

	_move1 = _group addWaypoint [_groupPos, 0];
	_move1 setWaypointType "MOVE";

	_patrolRoute = [_groupPos, 10, 500, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_move2 = _group addWaypoint [_patrolRoute, 0];
	_move2 setWaypointType "MOVE";

	_patrolRoute = [_groupPos, 10, 500, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_move3 = _group addWaypoint [_patrolRoute, 0];
	_move3 setWaypointType "MOVE";

	_move4 = _group addWaypoint [_groupPos, 0];
	_move4 setWaypointType "CYCLE";

	_group setBehaviour "SAFE";
	_group setCombatMode "RED";
	_group setSpeedMode "FULL";
	_group setFormation "DIAMOND";
};


if(_side == east) then {
	_squadComp = ["rhs_msv_emr_efreitor","rhs_msv_emr_medic","rhs_msv_emr_arifleman","rhs_msv_emr_at","rhs_msv_emr_efreitor","rhs_msv_emr_medic","rhs_msv_emr_rifleman","rhs_msv_emr_at"];
	_vehComp = ["rhs_tigr_sts_msv", "rhs_btr80_msv", "rhs_t90sm_tv", "RHS_Mi8MTV3_vdv", "RHS_Su25SM_Cluster_vvsc"];
	
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
		_vehicle = createVehicle [(_vehComp select 4), _groupPos, [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};

	_move1 = _group addWaypoint [_groupPos, 0];
	_move1 setWaypointType "MOVE";

	_patrolRoute = [_groupPos, 10, 500, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_move2 = _group addWaypoint [_patrolRoute, 0];
	_move2 setWaypointType "MOVE";

	_patrolRoute = [_groupPos, 10, 500, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_move3 = _group addWaypoint [_patrolRoute, 0];
	_move3 setWaypointType "MOVE";

	_move4 = _group addWaypoint [_groupPos, 0];
	_move4 setWaypointType "CYCLE";

	_group setBehaviour "SAFE";
	_group setCombatMode "RED";
	_group setSpeedMode "FULL";
	_group setFormation "DIAMOND";
};

if(_side == resistance) then {
	_squadComp = ["LOP_PMC_Infantry_SL", "LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_MG","LOP_PMC_Infantry_AT","LOP_PMC_Infantry_TL","LOP_PMC_Infantry_Corpsman","LOP_PMC_Infantry_Rifleman","LOP_PMC_Infantry_AT"];
	_vehComp = ["LOP_PMC_Offroad_M2", "rhsgref_ins_g_btr60", "rhsgref_ins_g_t72ba", "LOP_PMC_MH9_armed", "rhs_l39_cdf"];

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
		_vehicle = createVehicle [(_vehComp select 4), _groupPos, [], 0, "FLY"];
		_group = createVehicleCrew _vehicle;
	};

	_move1 = _group addWaypoint [_groupPos, 0];
	_move1 setWaypointType "MOVE";

	_patrolRoute = [_groupPos, 10, 500, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_move2 = _group addWaypoint [_patrolRoute, 0];
	_move2 setWaypointType "MOVE";

	_patrolRoute = [_groupPos, 10, 500, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_move3 = _group addWaypoint [_patrolRoute, 0];
	_move3 setWaypointType "MOVE";

	_move4 = _group addWaypoint [_groupPos, 0];
	_move4 setWaypointType "CYCLE";

	_group setBehaviour "SAFE";
	_group setCombatMode "RED";
	_group setSpeedMode "FULL";
	_group setFormation "DIAMOND";
};

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