_missionPos = _this param [0];
_enemySide = _this param [1];
_friendlySide = _this param [2];

missionNamespace setVariable["friendlySide", _friendlySide, true];
missionNamespace setVariable["planesKilled", 0, true];

//Create event hadler for this thing
addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	
	_objectCategory = (vehicle _unit call BIS_fnc_objectType) select 0;
	_objectType = (vehicle _unit call BIS_fnc_objectType) select 1;
	
	if((_objectType == "Plane" && typeOf _killer == typeOf vehicle _unit) || ((_objectType == "Plane" && typeOf _killer == typeOf vehicle _instigator))) then {
		missionNamespace setVariable["planesKilled", (missionNamespace getVariable "planesKilled") + 1, true];
		[format["[SERVER]: Planes killed = %1", (missionNamespace getVariable "planesKilled")]]remoteExec["systemChat", 0];
	};
}];


//Task
["killPlaneTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_killPlaneTask = [_friendlySide, ["killPlaneTask", "CAPTask"], ["Neutralize 15 enemy planes to complete the task.", "Neutralize enemy planes", ""], objNull, "UNASSIGNED", 1, true, "plane", false] call BIS_fnc_taskCreate;


//Task Trigger
_killPlaneTask = createTrigger ["EmptyDetector", _missionPos, false];
_killPlaneTask setTriggerStatements ["(missionNamespace getVariable 'planesKilled') >= 15", "
	['killPlaneTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
", ""];


(missionNamespace getVariable "missionCAPTasks") pushBack _killPlaneTask;


[] spawn {
	while {true} do {
		if((missionNamespace getVariable "planesKilled") == 15) exitWith {
			removeAllMissionEventHandlers "EntityKilled";
		};
	};
};