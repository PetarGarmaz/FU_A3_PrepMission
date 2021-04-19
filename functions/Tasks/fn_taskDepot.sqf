_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

_taskPos = [_missionPos, 200, 1500, 10, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;


//Spawn Objects
_depot = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compSupplyDepot.sqf"))] call BIS_fnc_ObjectsMapper;

_allObjects = _taskPos nearObjects 100;
(missionNamespace getVariable "allAttackSpawnedObjects") append _allObjects;


//Spawn markers
_markerPos = [_taskPos, 10, 300, 10, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;

_depotMarker = createMarker ["depotMarker", _markerPos];
_depotMarkerText = createMarker ["depotMarkerText", _markerPos];

"depotMarker" setMarkerShape "ELLIPSE";
"depotMarker" setMarkerBrush "Solid";
"depotMarker" setMarkerAlpha 0.5;
"depotMarker" setMarkerSize [300, 300];

"depotMarkerText" setMarkerType "mil_dot";
"depotMarkerText" setMarkerText "Find Supply Depot";
"depotMarkerText" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"depotMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"depotMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"depotMarker" setMarkerColor "colorIndependent";};

if(_enemySide == west) then {"depotMarkerText" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"depotMarkerText" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"depotMarkerText" setMarkerColor "colorIndependent";};


//Spawn Units
_spawnTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_spawnTrigger setVariable ["taskPos", _taskPos, true];
_spawnTrigger setVariable ["enemySide", _enemySide, true];
_spawnTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_spawnTrigger setTriggerArea [500, 500, 0, false, 200];

_spawnTrigger setTriggerStatements ["this", "
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 1] spawn Bizo_fnc_spawnDefenders;
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 1] spawn Bizo_fnc_spawnDefenders;
", ""];


//Task
["depotTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_depotTask = [_friendlySide, ["depotTask", "attackTask"], ["Find enemy supply depot", "Find Supply Depot", ""], objNull, "UNASSIGNED", 1, true, "search", false] call BIS_fnc_taskCreate;


//Trigger
_depotTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_depotTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_depotTrigger setTriggerArea [10, 10, 0, false, 10];
_depotTrigger setTriggerStatements ["this", "
	['depotTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState; 
	deleteMarker 'depotMarker';
	deleteMarker 'depotMarkerText';
", ""];

["[SERVER]: Enemy Supply Depot generated."] remoteExec ["systemChat", 0];
(missionNamespace getVariable "missionAttackTasks") pushBack _depotTrigger;