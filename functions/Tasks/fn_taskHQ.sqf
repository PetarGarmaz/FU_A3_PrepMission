_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

_taskPos = [_missionPos, 200, 1500, 10, 0, 0, 0, [], []] call BIS_fnc_findSafePos;

missionNamespace setVariable ["HQFlag", objNull, true];

//Spawn Objects
_randomHQ = selectRandom [1, 2];
_HQ = [_taskPos, 0, call (compile (preprocessFileLineNumbers format["Compositions\compHQ_%1.sqf", _randomHQ]))] call BIS_fnc_ObjectsMapper;
_allObjects = _taskPos nearObjects 100;

(missionNamespace getVariable "allAttackSpawnedObjects") append _allObjects;


//Spawn Markers
_HQMarker = createMarker ["HQMarker", _taskPos];

"HQMarker" setMarkerType "mil_flag";
"HQMarker" setMarkerText "Capture HQ";
"HQMarker" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"HQMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"HQMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"HQMarker" setMarkerColor "colorIndependent";};


//Spawn Units
_spawnTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_spawnTrigger setVariable ["taskPos", _taskPos, true];
_spawnTrigger setVariable ["enemySide", _enemySide, true];
_spawnTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_spawnTrigger setTriggerArea [500, 500, 0, false, 200];

_spawnTrigger setTriggerStatements ["this", "
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 1] spawn Bizo_fnc_spawnDefenders;
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 0] spawn Bizo_fnc_spawnDefenders;
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 3] spawn Bizo_fnc_spawnInBuilding;
", ""];


//Place a flag for capture
_flagType = "";

if(_enemySide == west) then {_flagType = "Flag_NATO_F"};
if(_enemySide == east) then {_flagType = "Flag_CSAT_F"};
if(_enemySide == resistance) then {_flagType = "Flag_AAF_F"};

_flag = createVehicle [_flagType, _taskPos, [], 0, "CAN_COLLIDE"];

missionNamespace setVariable ["HQFlag", _flag, true];


[_flag, ["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\interact_ca.paa'/> Capture the HQ", {
	_nextFlagPos = getPos (_this select 0);
	_flagType = "";
	
	deleteVehicle (_this select 0);
	
	if(side (_this select 1) == west) then {_flagType = "Flag_NATO_F"};
	if(side (_this select 1) == east) then {_flagType = "Flag_CSAT_F"};
	if(side (_this select 1) == resistance) then {_flagType = "Flag_AAF_F"};
	
	_flag = createVehicle [_flagType, _nextFlagPos, [], 0, "CAN_COLLIDE"];
}, nil, 1.5, true, true, "", "true", 3]] remoteExec ["addAction", -2, true];


//Task
["HQTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_HQTask = [_friendlySide, ["HQTask", "attackTask"], ["Capture the enemy HQ by capturing the flag inside it.", "Capture the HQ", ""], objNull, "UNASSIGNED", 1, true, "attack", false] call BIS_fnc_taskCreate;


//Trigger
_HQTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_HQTrigger setTriggerStatements ["!alive (missionNamespace getVariable 'HQFlag')", "
	['HQTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState; 
	deleteMarker 'HQMarker';
", ""];

["[SERVER]: Enemy HQ generated."] remoteExec ["systemChat", 0];
(missionNamespace getVariable "missionAttackTasks") pushBack _HQTrigger;