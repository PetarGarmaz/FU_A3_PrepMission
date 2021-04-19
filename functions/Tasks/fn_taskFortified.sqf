_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

_taskPos = [_missionPos, 100, 1500, 5, 0, 0.2, 0, [], []] call BIS_fnc_findSafePos;


//Spawn Objects
_fortifiedPos = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compFortified.sqf"))] call BIS_fnc_ObjectsMapper;
_allObjects = _taskPos nearObjects 100;

(missionNamespace getVariable "allAttackSpawnedObjects") append _allObjects;


//Marker
_fortiMarker = createMarker ["fortiMarker", _taskPos];

"fortiMarker" setMarkerType "mil_flag";
"fortiMarker" setMarkerText format["Secure Fortified Position"];
"fortiMarker" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"fortiMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"fortiMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"fortiMarker" setMarkerColor "colorIndependent";};


//Spawn Units
[_taskPos, _enemySide, 1, false] spawn Bizo_fnc_spawnInBuilding;

_spawnTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_spawnTrigger setVariable ["taskPos", _taskPos, true];
_spawnTrigger setVariable ["enemySide", _enemySide, true];
_spawnTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_spawnTrigger setTriggerArea [500, 500, 0, false, 200];

_spawnTrigger setTriggerStatements ["this", "
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 1] spawn Bizo_fnc_spawnDefenders;
	
", ""];


//Task
["fortiTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_fortiTask = [_friendlySide, ["fortiTask", "attackTask"], ["Secure enemy fortified position in the town.", "Secure Fortified position", ""], objNull, "UNASSIGNED", 1, true, "attack", false] call BIS_fnc_taskCreate;


//Task Trigger
_fortiTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_fortiTrigger setTriggerActivation [str _enemySide, "NOT PRESENT", false];
_fortiTrigger setTriggerArea [20, 20, 0, false, 200];
_fortiTrigger setTriggerStatements ["this", "
	['fortiTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState; 
	deleteMarker 'fortiMarker';
", ""];


["[SERVER]: Enemy fortified position created."] remoteExec ["systemChat", 0];
(missionNamespace getVariable "missionAttackTasks") pushBack _fortiTrigger;