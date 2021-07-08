_missionGiver = _this param [0];
_missionRequestee = _this param [1];
_userMissionLocation = _this param [2, ""];
_friendlySide = side _missionGiver;

missionNamespace setVariable ["missionMenu", true, true];
missionNamespace setVariable ["missionAttack", true, true];
missionNamespace setVariable ["missionAttackTasks", [], true];
missionNamespace setVariable ["allAttackSpawnedObjects", [], true];

//Find the mission location --------------------------------------------------------------------------------------------------
_missionLocationName = "";
_blacklistedLocations = ["", "Pogorevka","Zelenogorsk","Drozhino","Sosnovka","Pulkovo","Rogovo","Grishino","Krasnostav"];
_missionPos = [];


if(_userMissionLocation == "") then {
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
} else {
	_allLocations = nearestLocations [getMarkerPos "mapCenter", ["NameVillage","NameCityCapital", "NameCity"], 15000];
	
	{
		_missionLocation = _x;
		_missionLocationName = text _x;
		
		if(_missionLocationName == _userMissionLocation) then {
			_missionPos = [
				locationPosition _missionLocation select 0,
				locationPosition _missionLocation select 1,
				0
			];
			
			break;
		};
	}foreach _allLocations;
};

[_missionRequestee, "Requesting attack mission."] remoteExec ["sideChat", 0];

sleep 2;

[_missionGiver, format ["Copy that, you're going to %1! Good luck!", _missionLocationName]] remoteExec ["sideChat", 0];

sleep 2;


//Find enemy side --------------------------------------------------------------------------------------------------
_enemySide = "";

if(side _missionGiver == west) then {_randomSide = selectRandom[resistance, east]; _enemySide = _randomSide;};
if(side _missionGiver == east) then {_randomSide = selectRandom[west, resistance]; _enemySide = _randomSide;};
if(side _missionGiver == resistance) then {_randomSide = selectRandom[west, east]; _enemySide = _randomSide;};

sleep 1;


//Set the AO marker up --------------------------------------------------------------------------------------------------
_attackMarker = createMarker ["attackMarker", _missionPos];
_attackMarkerText = createMarker ["attackMarkerText", _missionPos];

"attackMarker" setMarkerShape "ELLIPSE";
"attackMarker" setMarkerBrush "FDiagonal";
"attackMarker" setMarkerSize [1500, 1500];

"attackMarkerText" setMarkerType "mil_objective";
"attackMarkerText" setMarkerText format["Attack %1", _missionLocationName];
"attackMarkerText" setMarkerSize [0.6, 0.6];

if(_enemySide == west) then {"attackMarker" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"attackMarker" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"attackMarker" setMarkerColor "colorIndependent";};

if(_enemySide == west) then {"attackMarkerText" setMarkerColor "colorBLUFOR";};
if(_enemySide == east) then {"attackMarkerText" setMarkerColor "colorOPFOR";};
if(_enemySide == resistance) then {"attackMarkerText" setMarkerColor "colorIndependent";};

sleep 1;


//Main task
["attackTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_attackTask = [_friendlySide, "attackTask", [format["Attack %1 and complete the objectives inside the AO.", _missionLocationName], format["Attack %1", _missionLocationName], ""], objNull, "ASSIGNED", 1, true, "attack", false] call BIS_fnc_taskCreate;


//Spawn Tasks in the AO --------------------------------------------------------------------------------------------------
_HQTask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskHQ;
waitUntil {scriptDone _HQTask};

_mortarTask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskMortar;
waitUntil {scriptDone _mortarTask};

_fortiTask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskFortified;
waitUntil {scriptDone _fortiTask};

_AATask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskAA;
waitUntil {scriptDone _AATask};

_depotTask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskDepot;
waitUntil {scriptDone _depotTask};

_RTTask = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskRT;
waitUntil {scriptDone _RTTask};


//Play Intro --------------------------------------------------------------------------------------------------
[_missionLocationName] remoteExec ["Bizo_fnc_spawnIntro", 0, true];


//Spawn random number of 1-4 random force multipliers...
_numberOfFM = [1, 4] call BIS_fnc_randomInt;

for "_i" from 1 to _numberOfFM do {
	_randomCheese = [2, 6] call BIS_fnc_randomInt;
	[_missionPos, _enemySide, _randomCheese] spawn Bizo_fnc_spawnDefenders;
};

while {true} do {
	if(triggerActivated ((missionNamespace getVariable "missionAttackTasks") select 0) && triggerActivated ((missionNamespace getVariable "missionAttackTasks") select 1) && triggerActivated ((missionNamespace getVariable "missionAttackTasks") select 2) && triggerActivated ((missionNamespace getVariable "missionAttackTasks") select 3) && triggerActivated ((missionNamespace getVariable "missionAttackTasks") select 4) && triggerActivated ((missionNamespace getVariable "missionAttackTasks") select 5)) exitWith {
		_doDefend = [1, 2, 3] call BIS_fnc_randomInt;
		
		['attackTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		
		deleteMarker "attackMarker";
		deleteMarker "attackMarkerText";
		
		missionNamespace setVariable ["missionAttackTasks", [], true];
		
		if (_doDefend == 1) then {
			_defendTaskFNC = [_missionPos, _enemySide, _friendlySide, _missionLocationName] spawn Bizo_fnc_taskDefend;
		}
		else {
			missionNamespace setVariable ["missionAttack", false, true];
			['EventTrack02_F_Orange'] remoteExec ['playMusic', 0];
		
			[_missionPos] spawn {
				sleep 60;

				_allEntities = (_this select 0) nearEntities [['Man', 'Car', 'Tank', 'Air'], 2000];
				
				{
					deleteVehicle _x;
				}foreach (missionNamespace getVariable 'allAttackSpawnedObjects');
				
				{
					if(isDamageAllowed _x && !(_x getVariable "isPersonalVehicle")) then {
						_vehicleCrew = crew _x;
						_crewMember = objNull;
						
						if(count _vehicleCrew > 0) then {_crewMember = _vehicleCrew select 0;};
						if(!isPlayer _crewMember) then {deleteVehicle _x;};
					};
				}foreach _allEntities;
			};
		};
	};
};