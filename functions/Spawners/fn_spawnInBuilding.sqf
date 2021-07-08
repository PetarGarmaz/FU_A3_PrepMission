_location = _this param[0];
_side = _this param [1];
_customChances = _this param [2, 4];
_doMove = _this param [3, true];
_customRadius = _this param [4, 100];

_listOfBuildingsInVicinity = _location nearObjects ["House", _customRadius];
_numOfBuildingsInVicinity = count _listOfBuildingsInVicinity;

_numOfOutsidePositions = _location nearObjects ["Land_Decal_RoadCrack_Grass_05_F", _customRadius];

for "_i" from 0 to _numOfBuildingsInVicinity do {
	_spotsInBuilding = [];

	if(_i != _numOfBuildingsInVicinity) then {
		_spotsInBuilding = _listOfBuildingsInVicinity select _i buildingPos -1;
	};
	
	if(count _spotsInBuilding > 0) then {
		{
			
			_randInt = [1, _customChances] call BIS_fnc_randomInt;
			
			if(_randInt == 1) then {
				_group = createGroup [_side, true];
				
				if(_side == west) then {_unit = _group createUnit ["rhsusf_army_ucp_rifleman", _x, [], 0, "CAN_COLLIDE"];};
				if(_side == east) then {_unit = _group createUnit ["rhs_msv_emr_rifleman", _x, [], 0, "CAN_COLLIDE"];};
				if(_side == resistance) then {_unit = _group createUnit ["LOP_PMC_Infantry_Rifleman", _x, [], 0, "CAN_COLLIDE"];};
				
				if(!_doMove) then {
					{
						_x disableAI "MOVE";
					}forEach units _group;
				};
			};
		}forEach _spotsInBuilding;
	};
};

{
	_group = createGroup [_side, true];
	_pos = getPos _x;

	if(_side == west) then {_unit = _group createUnit ["rhsusf_army_ucp_rifleman", _pos, [], 0, "CAN_COLLIDE"];};
	if(_side == east) then {_unit = _group createUnit ["rhs_msv_emr_rifleman", _pos, [], 0, "CAN_COLLIDE"];};
	if(_side == resistance) then {_unit = _group createUnit ["LOP_PMC_Infantry_Rifleman", _pos, [], 0, "CAN_COLLIDE"];};
	
	if(!_doMove) then {
		{
			_x disableAI "MOVE";
		}forEach units _group;
	};
}forEach _numOfOutsidePositions;