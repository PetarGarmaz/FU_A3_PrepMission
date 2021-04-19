_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];
_missionLocationName = _this param [3];

	
_currentHQ = nearestObjects [_missionPos, ["Flag_NATO_F", "Flag_CSAT_F", "Flag_AAF_F"], 3000, true];
_taskPos = getPos (_currentHQ select 0);


//Marker
_defendMarker = createMarker ["defendMarker", _taskPos];
_defendMarkerText = createMarker ["defendMarkerText", _taskPos];

"defendMarker" setMarkerShape "ELLIPSE";
"defendMarker" setMarkerBrush "Solid";
"defendMarker" setMarkerAlpha 0.5;
"defendMarker" setMarkerSize [500, 500];

"defendMarkerText" setMarkerType "mil_objective";
"defendMarkerText" setMarkerText "Defend HQ";

if(_friendlySide == west) then {"defendMarker" setMarkerColor "colorBLUFOR";};
if(_friendlySide == east) then {"defendMarker" setMarkerColor "colorOPFOR";};
if(_friendlySide == resistance) then {"defendMarker" setMarkerColor "colorIndependent";};

if(_friendlySide == west) then {"defendMarkerText" setMarkerColor "colorBLUFOR";};
if(_friendlySide == east) then {"defendMarkerText" setMarkerColor "colorOPFOR";};
if(_friendlySide == resistance) then {"defendMarkerText" setMarkerColor "colorIndependent";};


["defendTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_defendTask = [_friendlySide, "defendTask", [format["Head over to %1's HQ", _missionLocationName], format["Move to %1 HQ", _missionLocationName], ""], objNull, "ASSIGNED", 1, true, "walk", false] call BIS_fnc_taskCreate;


_moveToTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_moveToTrigger setTriggerActivation [str _friendlySide, "PRESENT", false];
_moveToTrigger setTriggerArea [200, 200, 0, false, 1000];
_moveToTrigger setTriggerStatements ["this", "['defendTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;", ""];


waitUntil {triggerActivated _moveToTrigger};


//Task
["defendTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_defendTask = [_friendlySide, "defendTask", [format["Bunker up in %1's HQ and defend it from incoming enemies!", _missionLocationName], format["Defend %1 HQ", _missionLocationName], ""], objNull, "ASSIGNED", 1, true, "defend", false] call BIS_fnc_taskCreate;


//Trigger
_defendTrigger = createTrigger ["EmptyDetector", _taskPos, false];
_defendTrigger setTriggerActivation [str _friendlySide, "NOT PRESENT", false];
_defendTrigger setTriggerArea [500, 500, 0, false, 1000];
_defendTrigger setTriggerStatements ["this", "
	['defendTask', 'FAILED', true] call BIS_fnc_taskSetState;
	['EventTrack02_F_Curator']remoteexec['playMusic', 0];
	missionNamespace setVariable ['missionAttack', false, true];
	
	deleteMarker 'defendMarker';
	deleteMarker 'defendMarkerText';
	
	[] spawn {
		sleep 300;
		
		{
			deleteVehicle _x;
		}foreach (missionNamespace getVariable 'allSpawnedObjects');
	};
", ""];

["LeadTrack02_F_Tank"]remoteexec["playMusic", 0];

_sleepIncrements = 240;

while {("defendTask" call BIS_fnc_taskState) != "FAILED"} do {
	sleep _sleepIncrements;
	
	_numberOfFM = [1, 3] call BIS_fnc_randomInt;
	
	for "_i" from 1 to _numberOfFM do {
		_randomCheese = [2, 7] call BIS_fnc_randomInt;
		[_missionPos, _enemySide, _randomCheese, _taskPos] spawn Bizo_fnc_spawnAttackers;
	};

	if(_sleepIncrements == 240) then {
		[_taskPos, _enemySide, 7, _taskPos] spawn Bizo_fnc_spawnAttackers;
	};
	
	if(_sleepIncrements == 180) then {
		[_taskPos, _enemySide, 7, _taskPos] spawn Bizo_fnc_spawnAttackers;
	};
	
	if(_sleepIncrements == 90) then {
		[_taskPos, _enemySide, 8, _taskPos] spawn Bizo_fnc_spawnAttackers;
	};
	
	if(_sleepIncrements == 60) then {
		[_taskPos, _enemySide, 6, _taskPos] spawn Bizo_fnc_spawnAttackers;
	};
	
	if(_sleepIncrements == 0) exitWith {
		["[SERVER]: Enemy attacks seems to have stopped. Clear out the remaining enemies!"] remoteExec ["systemChat", 0];
		
		deleteVehicle _defendTrigger;
		
		sleep 1;
		
		_defendTrigger = createTrigger ["EmptyDetector", _taskPos, false];
		_defendTrigger setTriggerActivation [str _enemySide, "NOT PRESENT", false];
		_defendTrigger setTriggerArea [500, 500, 0, false, 10];
		_defendTrigger setTriggerStatements ["this", "
			['defendTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
			['EventTrack02_F_Orange'] remoteExec ['playMusic', 0];
			missionNamespace setVariable ['missionAttack', false, true];
			
			deleteMarker 'defendMarker';
			deleteMarker 'defendMarkerText';
			
			[] spawn {
				sleep 300;
				
				{
					deleteVehicle _x;
				}foreach (missionNamespace getVariable 'allSpawnedObjects');
			};
		", ""];
	};
	
	_sleepIncrements = _sleepIncrements - 60;
};



