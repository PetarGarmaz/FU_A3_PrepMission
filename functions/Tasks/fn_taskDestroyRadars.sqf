_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];
_numOfRadars = [3, 8] call BIS_fnc_randomint;


//Spawn AA - Not a task
_taskPos = [_missionPos, 200, 7500, 10, 0, 0, 0, [], []] call BIS_fnc_findSafePos;

_AAPit = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compAA.sqf"))] call BIS_fnc_ObjectsMapper;
_aaBox = _taskPos nearObjects 100;
_aaType = "";

(missionNamespace getVariable "allCAPSpawnedObjects") append _aaBox;

if(_enemySide == west) then {_aaType = "FU_AntiAir_B"};
if(_enemySide == east) then {_aaType = "FU_AntiAir_O"};
if(_enemySide == resistance) then {_aaType = "FU_AntiAir_B"};

_aa = createVehicle [_aaType, _taskPos, [], 0, "CAN_COLLIDE"];

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
	
for "_i" from 1 to _numOfRadars do {
	_taskPos = [_missionPos, 200, 7500, 10, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_markerPos = [_taskPos, 10, 300, 10, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;

	missionNamespace setVariable ["radars", [], true];


	//Marker
	_radarMarker = createMarker [format["radarMarker_%1", _i], _markerPos];
	_radarMarkerArea = createMarker [format["radarMarkerArea_%1", _i], _markerPos];

	format["radarMarker_%1", _i] setMarkerType "mil_dot";
	format["radarMarker_%1", _i] setMarkerText "Radar Site";
	format["radarMarker_%1", _i] setMarkerSize [0.6, 0.6];

	format["radarMarkerArea_%1", _i] setMarkerShape "ELLIPSE";
	format["radarMarkerArea_%1", _i] setMarkerBrush "SolidBorder";
	format["radarMarkerArea_%1", _i] setMarkerSize [300, 300];

	//Spawn Objects
	_radarPit = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compAA.sqf"))] call BIS_fnc_ObjectsMapper;
	_radarType = "";
	_radarBox = _taskPos nearObjects 100;
	_aaType = "";
	
	(missionNamespace getVariable "allCAPSpawnedObjects") append _radarBox;
	

	//Spawn AA
	if(_enemySide == west) then {_radarType = "B_Radar_System_01_F"};
	if(_enemySide == east) then {_radarType = "O_Radar_System_02_F"};
	if(_enemySide == resistance) then {_radarType = "I_E_Radar_System_01_F"};

	_radar = createVehicle [_radarType, _taskPos, [], 0, "CAN_COLLIDE"];

	_allObjects = _taskPos nearObjects 100;
	(missionNamespace getVariable "allSpawnedObjects") append _allObjects;

	_radarGroup = createGroup _enemySide;
	_radarGroup = createVehicleCrew _radar;

	(missionNamespace getVariable 'radars') pushBack _radar;
	
	
	//Spawn loop to check if radar destroyed
	[_i, _radar]spawn {
		_i = _this select 0;
		_radar = _this select 1;
		
		while {true} do {
			if(!alive _radar) exitWith {
				missionNamespace setVariable ["radars", ((missionNamespace getVariable 'radars') - [_radar]), true];
				deleteMarker format["radarMarkerArea_%1", _i];
				deleteMarker format["radarMarker_%1", _i];
			};
		};
	};
	
	sleep 0.5;
};

//Task
["radarTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_radarTask = [_friendlySide, ["radarTask", "CAPTask"], ["Destroy enemy Radars.", "Destroy Radars", ""], objNull, "UNASSIGNED", 1, true, "destroy", false] call BIS_fnc_taskCreate;


//Task Trigger
_radarTrigger = createTrigger ["EmptyDetector", [0,0,0], false];
_radarTrigger setTriggerStatements ["count (missionNamespace getVariable 'radars') < 1", "
	['radarTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
", ""];


["[SERVER]: Enemy radars generated."] remoteExec ["systemChat", 0];
(missionNamespace getVariable "missionCAPTasks") pushBack _radarTrigger;