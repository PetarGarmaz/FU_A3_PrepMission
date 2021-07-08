_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

missionNamespace setVariable ["enemyOfficer", objNull, true];

//Get enemy officer
_officer = objNull;
_group = createGroup _enemySide;

if(_enemySide == west) then {_officer = _group createUnit ["rhsusf_army_ucp_riflemanl", _missionPos, [], 0, "CAN_COLLIDE"];};
if(_enemySide == east) then {_officer = _group createUnit ["rhs_msv_emr_officer_armored", _missionPos, [], 0, "CAN_COLLIDE"];};
if(_enemySide == resistance) then {_officer = _group createUnit ["LOP_PMC_Infantry_VIP", _missionPos, [], 0, "CAN_COLLIDE"];};

_group setBehaviour "SAFE";
_group setCombatMode "RED";
_group setSpeedMode "LIMITED";
_group setFormation "DIAMOND";

_move1 = _group addWaypoint [_missionPos, 0];
_move1 setWaypointType "MOVE";

_move2 = _group addWaypoint [_missionPos, 250];
_move2 setWaypointType "MOVE";

_move3 = _group addWaypoint [_missionPos, 250];
_move3 setWaypointType "MOVE";

_move4 = _group addWaypoint [_missionPos, 0];
_move4 setWaypointType "CYCLE";

missionNamespace setVariable ["enemyOfficer", _officer, true];


//Spawn enemies
_cheeseChoice = selectRandom [2, 6];

[_missionPos, _enemySide, 1] spawn Bizo_fnc_spawnDefenders;
[_missionPos, _enemySide, 1] spawn Bizo_fnc_spawnDefenders;
[_missionPos, _enemySide, 1] spawn Bizo_fnc_spawnDefenders;
[_missionPos, _enemySide, 1] spawn Bizo_fnc_spawnDefenders;
[_missionPos, _enemySide, _cheeseChoice] spawn Bizo_fnc_spawnDefenders;


//Set the AO marker up --------------------------------------------------------------------------------------------------
_assassinateMarker = createMarker ["assassinateMarker", _missionPos];
_assassinateMarkerText = createMarker ["assassinateMarkerText", _missionPos];

"assassinateMarker" setMarkerShape "ELLIPSE";
"assassinateMarker" setMarkerBrush "FDiagonal";
"assassinateMarker" setMarkerSize [500, 500];

"assassinateMarkerText" setMarkerType "mil_objective";
"assassinateMarkerText" setMarkerText "Assasinate Enemy Officer";
"assassinateMarkerText" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"assassinateMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"assassinateMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"assassinateMarker" setMarkerColor "colorIndependent";};

if(_enemySide == west) then {"assassinateMarkerText" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"assassinateMarkerText" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"assassinateMarkerText" setMarkerColor "colorIndependent";};

sleep 1;


//Main task
["assassinateTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_assassinateTask = [_friendlySide, ["assassinateTask", "attackTask"], ["Assassinate enemy officer", "Assassinate Officer", ""], objNull, "ASSIGNED", 1, true, "kill", false] call BIS_fnc_taskCreate;


//Main Trigger
_assassinateTrigger = createTrigger ["EmptyDetector", _missionPos, false];
_assassinateTrigger setTriggerStatements ["!alive (missionNamespace getVariable 'enemyOfficer')", "
	['assassinateTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState; 
	deleteMarker 'assassinateMarker';
	deleteMarker 'assassinateMarkerText';
", ""];

(missionNamespace getVariable "missionAttackTasks") pushBack _assassinateTrigger;