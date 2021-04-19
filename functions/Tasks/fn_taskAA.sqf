_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

_taskPos = [_missionPos, 200, 1000, 10, 0, 0.4, 0, [], []] call BIS_fnc_findSafePos;

missionNamespace setVariable ["AA", objNull, true];


//Marker
_AAMarker = createMarker ["AAMarker", _taskPos];

"AAMarker" setMarkerType "mil_destroy";
"AAMarker" setMarkerText format["AA"];
"AAMarker" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"AAMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"AAMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"AAMarker" setMarkerColor "colorIndependent";};


//Spawn Objects
_AAPit = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compAA.sqf"))] call BIS_fnc_ObjectsMapper;
_aaType = "";


//Spawn AA
if(_enemySide == west) then {_aaType = "FU_AntiAir_B"};
if(_enemySide == east) then {_aaType = "FU_AntiAir_O"};
if(_enemySide == resistance) then {_aaType = "FU_AntiAir_B"};

_aa = createVehicle [_aaType, _taskPos, [], 0, "CAN_COLLIDE"];

_allObjects = _taskPos nearObjects 100;
(missionNamespace getVariable "allAttackSpawnedObjects") append _allObjects;

if(_enemySide != resistance) then {
	_aaGroup = createGroup _enemySide;
	_aaGroup = createVehicleCrew _aa;
}
else {
	_aaGroup = createGroup _enemySide;
	
	_unit1 = _aaGroup createUnit ["I_Soldier_F", _taskPos, [], 0, "NONE"];
	_unit2 = _aaGroup createUnit ["I_Soldier_F", _taskPos, [], 0, "NONE"];
	_unit3 = _aaGroup createUnit ["I_Soldier_F", _taskPos, [], 0, "NONE"];
	
	_unit1 moveInAny _aa;
	_unit2 moveInAny _aa;
	_unit3 moveInAny _aa;
};

missionNamespace setVariable ['AA', _aa, true];


//Spawn Units
_spawnTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_spawnTrigger setVariable ["taskPos", _taskPos, true];
_spawnTrigger setVariable ["enemySide", _enemySide, true];
_spawnTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_spawnTrigger setTriggerArea [500, 500, 0, false, 200];

_spawnTrigger setTriggerStatements ["this", "
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 0] spawn Bizo_fnc_spawnDefenders;
", ""];

//Task
["AATask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_AATask = [_friendlySide, ["AATask", "attackTask"], ["Destroy Anti Air.", "Destroy AA", ""], objNull, "UNASSIGNED", 1, true, "destroy", false] call BIS_fnc_taskCreate;


//Task Trigger
_AATrigger = createTrigger ["EmptyDetector", _taskPos, false];
_AATrigger setTriggerStatements ["!alive (missionNamespace getVariable 'AA')", "
	['AATask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	deleteMarker 'AAMarker';
", ""];


["[SERVER]: Enemy AA generated."] remoteExec ["systemChat", 0];
(missionNamespace getVariable "missionAttackTasks") pushBack _AATrigger;