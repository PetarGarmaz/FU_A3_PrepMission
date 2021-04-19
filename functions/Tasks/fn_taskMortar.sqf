_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

_taskPos = [_missionPos, 200, 1500, 5, 0, 0.3, 0, [], []] call BIS_fnc_findSafePos;

missionNamespace setVariable ["mortars", [], true];

//Spawn Objects
_mortarPit1 = [[(_taskPos select 0) + 15, (_taskPos select 1), (_taskPos select 2)], 0, call (compile (preprocessFileLineNumbers "Compositions\compMortar.sqf"))] call BIS_fnc_ObjectsMapper;
_mortarPit2 = [[(_taskPos select 0), (_taskPos select 1) + 15, (_taskPos select 2)], 0, call (compile (preprocessFileLineNumbers "Compositions\compMortar.sqf"))] call BIS_fnc_ObjectsMapper;
_mortarPit3 = [_taskPos, 0, call (compile (preprocessFileLineNumbers "Compositions\compMortar.sqf"))] call BIS_fnc_ObjectsMapper;


//Mortar Marker
_mortarMarker = createMarker ["mortarMarker", _taskPos];

"mortarMarker" setMarkerType "mil_flag";
"mortarMarker" setMarkerText "Secure Mortar Pit";
"mortarMarker" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"mortarMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"mortarMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"mortarMarker" setMarkerColor "colorIndependent";};


//Spawn mortars
for "_i" from 1 to 3 do {
	[_taskPos, _enemySide, _i]spawn {
		_taskPos = _this select 0;
		_enemySide = _this select 1;
		
		_i = _this select 2;
	
		_m = 0;
		_n = 0;
		
		_mortarType = "";
		
		if(_i == 1) then {_m = 15; _n = 0;};
		if(_i == 2) then {_m = 0; _n = 15;};
		if(_i == 3) then {_m = 0; _n = 0;};

		if(_enemySide == west) then {_mortarType = "B_Mortar_01_F"};
		if(_enemySide == east) then {_mortarType = "O_Mortar_01_F"};
		if(_enemySide == resistance) then {_mortarType = "I_Mortar_01_F"};
		
		sleep 1;
		
		_mortarGroup = createGroup _enemySide;
		_mortar = createVehicle [_mortarType, [(_taskPos select 0) + _m, (_taskPos select 1) + _n, 0], [], 0, "CAN_COLLIDE"];
		_mortarGroup = createVehicleCrew _mortar;
		
		(missionNamespace getVariable 'mortars') pushBack _mortar;
	};
	
	sleep 1;
};

_allObjects = _taskPos nearObjects 100;
(missionNamespace getVariable "allAttackSpawnedObjects") append _allObjects;


//Spawn Units
_spawnTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_spawnTrigger setVariable ["taskPos", _taskPos, true];
_spawnTrigger setVariable ["enemySide", _enemySide, true];
_spawnTrigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
_spawnTrigger setTriggerArea [500, 500, 0, false, 200];

_spawnTrigger setTriggerStatements ["this", "
	[thisTrigger getVariable 'taskPos', thisTrigger getVariable 'enemySide', 1] spawn Bizo_fnc_spawnDefenders;
", ""];


//Task
["mortarTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_mortarTask = [_friendlySide, ["mortarTask", "attackTask"], ["Find and secure the enemy mortar pit", "Secure Mortar pit", ""], objNull, "UNASSIGNED", 1, true, "destroy", false] call BIS_fnc_taskCreate;


//Task Trigger
_mortarTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_mortarTrigger setTriggerStatements ["!alive (gunner ((missionNamespace getVariable 'mortars') select 0))  && !alive (gunner ((missionNamespace getVariable 'mortars') select 1)) && !alive (gunner ((missionNamespace getVariable 'mortars') select 2))", "
	['mortarTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
	deleteMarker 'mortarMarker';
", ""];



_fireMissionTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_fireMissionTrigger setTriggerActivation ["ANYPLAYER", str _enemySide + " D", false];
_fireMissionTrigger setTriggerArea [1000, 1000, 0, false, 200];

_fireMissionTrigger setTriggerStatements ["this", "
	
", ""];

//Fire mission trigger
_fireMission = [_taskPos, _enemySide] spawn {
	_taskPos = _this select 0;
	_enemySide = _this select 1;

	while {['mortarTask'] call BIS_fnc_taskState != 'SUCCEEDED'} do {
		_nearPlayers = [];
		{if (isPlayer _x) then {_nearPlayers pushBack _x;};} foreach (_taskPos nearEntities ["Man", 1000]);
		
		if(count _nearPlayers > 0) then {
			_randomTarget = selectRandom _nearPlayers;
			
			if(_enemySide knowsAbout _randomTarget == 4) then {
				[_randomTarget] spawn Bizo_fnc_artillery;
				sleep 110;
			};
		};
	};
};

["[SERVER]: Enemy mortar pit generated."] remoteExec ["systemChat", 0];
(missionNamespace getVariable "missionAttackTasks") pushBack _mortarTrigger;