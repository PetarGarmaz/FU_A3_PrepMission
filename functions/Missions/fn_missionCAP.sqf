_missionGiver = _this param [0];
_missionRequestee = _this param [1];
_friendlySide = side _missionGiver;

missionNamespace setVariable ["missionMenu", true, true];
missionNamespace setVariable ["missionCAP", true, true];
missionNamespace setVariable ["missionCAPTasks", [], true];
missionNamespace setVariable ["allCAPSpawnedObjects", [], true];

//Find the mission location --------------------------------------------------------------------------------------------------
_missionLocationName = "";
_blacklistedLocations = [""];
_missionPos = [];

while {_missionLocationName in _blacklistedLocations} do {
	_allLocations = nearestLocations [getMarkerPos "mapCenter", ["NameVillage","NameCityCapital", "NameCity"], 15000];
	_missionLocation = selectRandom _allLocations;
	_missionLocationName = text _missionLocation;
	_missionPos = [
		locationPosition _missionLocation select 0,
		locationPosition _missionLocation select 1,
		0
	];
};

[_missionRequestee, "Requesting CAP mission."] remoteExec ["sideChat", 0];

sleep 2;

[_missionGiver, format ["Alright, prepare your plane, you're going to %1! Good luck!", _missionLocationName]] remoteExec ["sideChat", 0];

sleep 2;


//Find enemy side --------------------------------------------------------------------------------------------------
_enemySide = "";

if(side _missionGiver == west) then {_randomSide = selectRandom[resistance, east]; _enemySide = _randomSide;};
if(side _missionGiver == east) then {_randomSide = selectRandom[west, resistance]; _enemySide = _randomSide;};
if(side _missionGiver == resistance) then {_randomSide = selectRandom[west, east]; _enemySide = _randomSide;};

sleep 1;


//Set the AO marker up --------------------------------------------------------------------------------------------------
_CAPMarker = createMarker ["CAPMarker", _missionPos];
_CAPMarkerText = createMarker ["CAPMarkerText", _missionPos];

"CAPMarker" setMarkerShape "ELLIPSE";
"CAPMarker" setMarkerBrush "Solid";
"CAPMarker" setMarkerAlpha 0.25;
"CAPMarker" setMarkerSize [7500, 7500];

"CAPMarkerText" setMarkerType "mil_objective";
"CAPMarkerText" setMarkerText format["Control airspace above %1", _missionLocationName];
"CAPMarkerText" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"CAPMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"CAPMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"CAPMarker" setMarkerColor "colorIndependent";};

if(_enemySide == west) then {"CAPMarkerText" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"CAPMarkerText" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"CAPMarkerText" setMarkerColor "colorIndependent";};

sleep 1;


//Enemy spawner
[_missionPos, _enemySide] spawn {
	_missionPos = _this select 0;
	_enemySide = _this select 1;

	while {true} do {
		if((missionNamespace getVariable "planesKilled") >= 15) exitWith {
			hint "";
		};
		
		_randomSleep = [120, 240] call BIS_fnc_randomInt;
		
		sleep _randomSleep;
		
		if((missionNamespace getVariable "planesKilled") < 15) then {
			[_missionPos, _enemySide, 6, _missionPos] spawn Bizo_fnc_spawnAttackers;
			[_missionPos, _enemySide, 6, _missionPos] spawn Bizo_fnc_spawnAttackers;
			[_missionPos, _enemySide, 6, _missionPos] spawn Bizo_fnc_spawnAttackers;
		};
		
	};
};


//Main task
["CAPTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_attackTask = [_friendlySide, "CAPTask", [format["Control airspace above %1.", _missionLocationName], format["Control %1's airspace", _missionLocationName], ""], objNull, "ASSIGNED", 1, true, "Default", false] call BIS_fnc_taskCreate;


//Spawn Tasks in the AO --------------------------------------------------------------------------------------------------
_killPlanesTask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskKillPlanes;
waitUntil {scriptDone _killPlanesTask};

_radarTask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskDestroyRadars;
waitUntil {scriptDone _radarTask};


while {true} do {
	if(triggerActivated ((missionNamespace getVariable "missionCAPTasks") select 0) && triggerActivated ((missionNamespace getVariable "missionCAPTasks") select 1)) exitWith {
		['CAPTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		['EventTrack02_F_Orange'] remoteExec ['playMusic', 0];
		
		deleteMarker "CAPMarker";
		deleteMarker "CAPMarkerText";
		
		missionNamespace setVariable ["missionCAP", false, true];
		missionNamespace setVariable ["missionCAPTasks", [], true];
		
		[] spawn {		
			{
				deleteVehicle _x;
			}foreach (missionNamespace getVariable 'allCAPSpawnedObjects');
		}
	};
};