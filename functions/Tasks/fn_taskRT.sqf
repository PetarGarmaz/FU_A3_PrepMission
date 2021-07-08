_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

_taskPos = [_missionPos, 200, 1500, 5, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;

missionNamespace setVariable ["RTDisabled", false, true];
missionNamespace setVariable ["RT", objNull, true];

//Spawn Objects
_RTBase = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compRT.sqf"))] call BIS_fnc_ObjectsMapper;


//Spawn Markers
_RTMarker = createMarker ["RTMarker", _taskPos];

"RTMarker" setMarkerType "mil_destroy";
"RTMarker" setMarkerText "Disable Radio Tower";
"RTMarker" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"RTMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"RTMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"RTMarker" setMarkerColor "colorIndependent";};


//Place a RT
_rt = createVehicle ["Land_TTowerBig_2_F", _taskPos, [], 0, "CAN_COLLIDE"];
missionNamespace setVariable ["RT", _rt, true];
_rt setVectorUp [0,0,1];


//Place Minefield
for "_i" from 1 to 100 do {
	_minePos = [_taskPos, 20, 70, 1, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_mine = createVehicle ["APERSMine_Range_Ammo", _minePos, [], 0, "CAN_COLLIDE"];
};

_allObjects = _taskPos nearObjects 100;
(missionNamespace getVariable "allAttackSpawnedObjects") append _allObjects;


//Find the switch
_switch = nearestObject [_taskPos, "Land_TransferSwitch_01_F"];
_switch animateSource["SwitchPosition", 1];
_switch animateSource["SwitchLight", 1];
_switch animateSource["Power_1", 1];
_switch animateSource["Power_2", 1];


[_switch, ["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\interact_ca.paa'/> Disable the Radio Tower", {
	(_this select 0) animateSource["SwitchPosition", 0];
	(_this select 0) animateSource["SwitchLight", 0];
	(_this select 0) animateSource["Power_1", 0];
	(_this select 0) animateSource["Power_2", 0];
	
	missionNamespace setVariable ["RTDisabled", true, true];
	
	(_this select 0) removeAction (_this select 2);
}, nil, 1.5, true, true, "", "(_this getVariable 'ACE_IsEngineer') > 0", 3]] remoteExec ["addAction", -2, true];


//Task
["RTTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_RTTask = [_friendlySide, ["RTTask", "attackTask"], ["Disable enemy radio tower. Engineer is required to complete this task. If no engineer is present, destroy the tower instead.", "Disable Radio Tower", ""], objNull, "UNASSIGNED", 1, true, "interact", false] call BIS_fnc_taskCreate;


//Trigger
_RTTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_RTTrigger setTriggerStatements ["(missionNamespace getVariable 'RTDisabled') || !alive(missionNamespace getVariable 'RT')", "
	['RTTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState; 
	deleteMarker 'RTMarker';
", ""];

["[SERVER]: Enemy RT created."] remoteExec ["systemChat", 0];
(missionNamespace getVariable "missionAttackTasks") pushBack _RTTrigger;