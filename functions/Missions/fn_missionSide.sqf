_missionGiver = _this param [0];
_missionRequestee = _this param [1];
_friendlySide = side _missionGiver;

missionNamespace setVariable ["missionMenu", true, true];
missionNamespace setVariable ["missionAttack", true, true];
missionNamespace setVariable ["missionAttackTasks", [], true];
missionNamespace setVariable ["allAttackSpawnedObjects", [], true];


//Random task ---------------------------------------------------------------------------------------------------
_missionChoices = [
	[0, "Destroy enemy Anti Air battery"],
	[1, "Secure enemy fortified area"],
	[2, "Secure enemy controlled headquarters"],
	[3, "Assassinate enemy officer"],
	[4, "Disable enemy radio tower"]
];

_selectedMission = selectRandom _missionChoices;


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

[_missionRequestee, "Requesting random side mission."] remoteExec ["sideChat", 0];

sleep 2;

[_missionGiver, format ["Roger, you're going to %1 in %2! Good luck!", toLower(_selectedMission select 1), _missionLocationName]] remoteExec ["sideChat", 0];

sleep 2;


//Find enemy side --------------------------------------------------------------------------------------------------
_enemySide = "";

if(side _missionGiver == west) then {_randomSide = selectRandom[resistance, east]; _enemySide = _randomSide;};
if(side _missionGiver == east) then {_randomSide = selectRandom[west, resistance]; _enemySide = _randomSide;};
if(side _missionGiver == resistance) then {_randomSide = selectRandom[west, east]; _enemySide = _randomSide;};

sleep 1;

//Main task
["attackTask", _friendlySide] call BIS_fnc_deleteTask;
sleep 1;
_sideTask = [_friendlySide, "attackTask", ["Side Task", "Side Task", ""], objNull, "ASSIGNED", 1, true, "unknown", false] call BIS_fnc_taskCreate;


//Spawn Task
_task = scriptNull;

if(_selectedMission select 0 == 0) then {_task = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskAA;};
if(_selectedMission select 0 == 1) then {_task = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskFortified;};
if(_selectedMission select 0 == 2) then {_task = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskHQ;};
if(_selectedMission select 0 == 3) then {_task = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskOfficer;};
if(_selectedMission select 0 == 4) then {_task = [_missionPos, _enemySide, _friendlySide] spawn Bizo_fnc_taskRT;};


//Spawn random number of 1-2 random force multipliers...
_numberOfFM = [1, 2] call BIS_fnc_randomInt;

for "_i" from 1 to _numberOfFM do {
	_randomCheese = [2, 6] call BIS_fnc_randomInt;
	[_missionPos, _enemySide, _randomCheese] spawn Bizo_fnc_spawnDefenders;
};



//Main Trigger
while {true} do {
	if(triggerActivated ((missionNamespace getVariable "missionAttackTasks") select 0)) exitWith {
		['attackTask', 'SUCCEEDED', true] call BIS_fnc_taskSetState;
		
		missionNamespace setVariable ["missionAttackTasks", [], true];

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