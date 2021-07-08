_displayType = _this param [0];
_user = player;

//Lock
if(_displayType == 0) then {
	_year = date select 0;
	_month = date select 1;
	_day = date select 2;
	_hour = date select 3;
	_minute = date select 4;

	_hour = [_hour, "HH"] call BIS_fnc_timeToString;
	_minute = [_minute, "HH"] call BIS_fnc_timeToString;
	_weatherImages = ["Images\GUI\FUT_WeatherSunny.paa", "Images\GUI\FUT_WeatherOvercast.paa", "Images\GUI\FUT_WeatherCloudy.paa"];
	_loc = "";
	_weather = "";

	_dayNum = [_day, 0] call Bizo_fnc_numberToText;
	_month = [_month, 1] call Bizo_fnc_numberToText;
	_dayText = [_day, 2] call Bizo_fnc_numberToText;
	_alt = (getPosASL player) select 2;
	_temp = round(_alt call ace_weather_fnc_calculateTemperatureAtHeight);
	
	{
		_newLoc = nearestLocation [player, _x];
		_newDistance = (getPos _newLoc) distance (getPos player);

		if(_forEachIndex == 0) then {
			_loc = nearestLocation [player, _x];
		};
		
		_distance = (getPos _loc) distance (getPos player);
		
		if(_newDistance < _distance) then {
			_loc = _newLoc;
		};
	}foreach ["NameVillage", "NameCityCapital", "NameCity"];
	
	_loc = text _loc;
	
	if(overcast >= 0 && overcast <= 0.3) then {
		_weather = _weatherImages select 0;
	};
	
	if(overcast > 0.3 && overcast <= 0.6) then {
		_weather = _weatherImages select 1;
	};
	
	if(overcast > 0.6) then {
		_weather = _weatherImages select 2;
	};

	createDialog "TabletLockScreen";

	_timeCtrl = (findDisplay 4600) displayCtrl 4618;
	_dateCtrl = (findDisplay 4600) displayCtrl 4619;
	_weatherCtrl = (findDisplay 4600) displayCtrl 4616;
	_tempCtrl = (findDisplay 4600) displayCtrl 4615;
	_locCtrl = (findDisplay 4600) displayCtrl 4614;
	_homeButton = (findDisplay 4600) displayCtrl 4617;

	_timeCtrl ctrlSetStructuredText parseText format["<t size=""3"">%1:%2</t>", _hour, _minute];
	_dateCtrl ctrlSetText format["%1, %2 %3, %4", _dayText, _month, _dayNum, _year];
	
	_tempCtrl ctrlSetStructuredText parseText format["<t size=""3"">%1°</t>", _temp];
	_locCtrl ctrlSetText format["%1", _loc];
	_weatherCtrl ctrlSetText _weather;
	
	_homeAction = _homeButton buttonSetAction "
		closeDialog 2;
		[1] spawn Bizo_fnc_tablet;
	"; 
};

//Home
if(_displayType == 1) then {
	_hour = date select 3;
	_minute = date select 4;

	_hour = [_hour, "HH"] call BIS_fnc_timeToString;
	_minute = [_minute, "HH"] call BIS_fnc_timeToString;

	createDialog "TabletMenuScreen";

	//_timeCtrl = (findDisplay 4601) displayCtrl 4618;
	//_dateCtrl = (findDisplay 4601) displayCtrl 4619;
	_statsButton = (findDisplay 4601) displayCtrl 4612;
	_garageButton = (findDisplay 4601) displayCtrl 4613;
	_missionsButton = (findDisplay 4601) displayCtrl 4614;
	_supplyDropButton = (findDisplay 4601) displayCtrl 4615;
	_groupButton = (findDisplay 4601) displayCtrl 4616;
	_settingsButton = (findDisplay 4601) displayCtrl 4617;
	_homeButton = (findDisplay 4601) displayCtrl 4618;

	//_timeCtrl ctrlSetStructuredText parseText format["<t size=""3"">%1:%2</t>", _hour, _minute];
	
	_homeAction = _homeButton buttonSetAction "
		closeDialog 2;
		[0] spawn Bizo_fnc_tablet;
	";
	
	_statsAction = _statsButton buttonSetAction "
		closeDialog 2;
		[2] spawn Bizo_fnc_tablet;
	";
	
	_garageAction = _garageButton buttonSetAction "
		closeDialog 2;
		[3] spawn Bizo_fnc_tablet;
	";
	
	_missionsAction = _missionsButton buttonSetAction "
		closeDialog 2;
		if(side player != civilian)then{[4] spawn Bizo_fnc_tablet;}else{systemChat '[LOCAL]: Civilians cannot accept missions!'};
	";
	
	_supplyDropAction = _supplyDropButton buttonSetAction "
		closeDialog 2;
		[8] spawn Bizo_fnc_tablet;
	";
	
	_groupAction = _groupButton buttonSetAction "
		closeDialog 2;
		[12] spawn Bizo_fnc_tablet;
	";
	
	_settingsAction = _settingsButton buttonSetAction "
		closeDialog 2;
		[13] spawn Bizo_fnc_tablet;
	";
	
};

//Stats
if(_displayType == 2) then {
	_kills = player getVariable "totalKills";
	_deaths = (getPlayerScores player) select 4;
	_kdr = 0;
	_shots = player getVariable "shotsFired";
	_spk = 0;
	_maxLifetime = [(player getVariable "maxLifeTime")/60, 0] call BIS_fnc_cutDecimals;
	
	if(_kills == 0) then {_spk = _shots;} else {_spk = _shots / _kills;};
	if(_deaths == 0) then {_kdr = _kills;} else {_kdr = _kills/_deaths};
	
	_spk = [_spk, 1] call BIS_fnc_cutDecimals;
	
	_allStatsValues = [_kills, _deaths, _kdr, _shots, _spk, _maxLifetime];
	_allStats = ["Kills", "Deaths", "KDR", "Shots Fired", "SPK", "Max Lifetime"];
	_displayedStat = [0, ""];

	createDialog "TabletStatsScreen";

	_homeButton = (findDisplay 4602) displayCtrl 4618;
	_backButton = (findDisplay 4602) displayCtrl 4619;
	
	for "_i" from 4612 to 4617 do {
		_statText = (findDisplay 4602) displayCtrl _i;
		_index = (_i % 10) - 2;

		_displayedStat = [_allStatsValues select _index, _allStats select _index];
	
		_statText ctrlSetStructuredText parseText format["<t align= ""center"" valign= ""middle"" size=""2.25"">%1</t> <br/> <t align= ""center"" valign= ""middle"" size=""0.6"">%2</t>", [_displayedStat select 0, 1] call BIS_fnc_cutDecimals, _displayedStat select 1];
	};
	
	_backAction = _backButton buttonSetAction "
		closeDialog 2;
		[1] spawn Bizo_fnc_tablet;
	";
	
	_homeAction = _homeButton buttonSetAction "
		closeDialog 2;
		[0] spawn Bizo_fnc_tablet;
	";
};

//Virtual Garage
if(_displayType == 3) then {
	_vehicleSpawns = [];
	{if("vehicleSpawn_" in _x) then {_vehicleSpawns pushBack _x}}forEach allMapMarkers;
	
	_closestVehicleSpawn = "";
	_distance = 0;
	
	{
		_newVehicleSpawn = _x;
		_newDistance = player distance (getMarkerPos _newVehicleSpawn);

		if(_forEachIndex == 0) then {
			_closestVehicleSpawn = _x;
			_distance = player distance (getMarkerPos _closestVehicleSpawn);
		};
		
		if(_newDistance < _distance) then {
			_closestVehicleSpawn = _newVehicleSpawn;
			_distance = _newDistance;
		};
	}foreach _vehicleSpawns;
	
	if(_distance <= 300) then {
		_nearVehicles = getMarkerPos _closestVehicleSpawn nearEntities [["Air", "Car", "Motorcycle", "Tank"], 30];
		
		if(count _nearVehicles == 0) then {
			_personalVehicle = player getVariable "personalVehicle";
			
			if(!(isNull _personalVehicle)) then {
				deleteVehicle (player getVariable "personalVehicle");
				player setVariable ["personalVehicle", objNull, true];
			};	
		
			[_closestVehicleSpawn, side player, player] call opec_fnc_garageNew;
			[format ["[SERVER]: %1 pulled a vehicle from %2.", name _user, markerText _closestVehicleSpawn]] remoteExec ["systemChat", 0];
		} else {
			["[SERVER]: Clear the spawn area!"] remoteExec ["systemChat", 0];
		};
	} else {
		[1] spawn Bizo_fnc_tablet;
		systemChat "[LOCAL]: You're too far from any Virtual Garage spawns!";
	};
};

//Missions
if(_displayType == 4) then {
	createDialog "TabletMissions";

	_mainButton = (findDisplay 4603) displayCtrl 4612;
	_capButton = (findDisplay 4603) displayCtrl 4613;
	_sideButton = (findDisplay 4603) displayCtrl 4614;
	_homeButton = (findDisplay 4603) displayCtrl 4618;
	_backButton = (findDisplay 4603) displayCtrl 4619;
	
	_mainAction = _mainButton buttonSetAction "
		closeDialog 2;
		[5] spawn Bizo_fnc_tablet;
	";
	
	_capAction = _capButton buttonSetAction "
		closeDialog 2;
		[6] spawn Bizo_fnc_tablet;
	";
	
	_sideAction = _sideButton buttonSetAction "
		closeDialog 2;
		[7] spawn Bizo_fnc_tablet;
	";
	
	_backAction = _backButton buttonSetAction "
		closeDialog 2;
		[1] spawn Bizo_fnc_tablet;
	";
	
	_homeAction = _homeButton buttonSetAction "
		closeDialog 2;
		[0] spawn Bizo_fnc_tablet;
	";
};

//Mission - Main
if(_displayType == 5) then {
	_missionGiver = objNull;

	if(side player == west) then {_missionGiver = usaf_officer};
	if(side player == east) then {_missionGiver = afrf_officer};
	if(side player == resistance) then {_missionGiver = pmc_officer};
	
	if(not(missionNamespace getVariable "missionAttack")) then {
		[_missionGiver, _user] remoteExec ["Bizo_fnc_missionAttack", 2];
	} else {
		[4] spawn Bizo_fnc_tablet;
		systemChat "[LOCAL]: One of the factions already has this mission type active!";
	};
};

//Mission - CAP
if(_displayType == 6) then {
	_missionGiver = objNull;

	if(side player == west) then {_missionGiver = usaf_officer};
	if(side player == east) then {_missionGiver = afrf_officer};
	if(side player == resistance) then {_missionGiver = pmc_officer};
	
	if(not(missionNamespace getVariable "missionCAP")) then {
		[_missionGiver, _user] remoteExec ["Bizo_fnc_missionCAP", 2];
	} else {
		[4] spawn Bizo_fnc_tablet;
		systemChat "[LOCAL]: One of the factions already has this mission type active!";
	};
};

//Mission - Side
if(_displayType == 7) then {
	_missionGiver = objNull;

	if(side player == west) then {_missionGiver = usaf_officer};
	if(side player == east) then {_missionGiver = afrf_officer};
	if(side player == resistance) then {_missionGiver = pmc_officer};
	
	if(not(missionNamespace getVariable "missionAttack")) then {
		[_missionGiver, _user] remoteExec ["Bizo_fnc_missionSide", 2];
	} else {
		[4] spawn Bizo_fnc_tablet;
		systemChat "[LOCAL]: One of the factions already has this mission type active!";
	};
};

//Supply drop
if(_displayType == 8) then {
	createDialog "TabletSupplyDrop";

	_quadButton = (findDisplay 4604) displayCtrl 4612;
	_recruitButton = (findDisplay 4604) displayCtrl 4613;
	_suppliesButton = (findDisplay 4604) displayCtrl 4614;
	_homeButton = (findDisplay 4604) displayCtrl 4618;
	_backButton = (findDisplay 4604) displayCtrl 4619;
	
	_quadAction = _quadButton buttonSetAction "
		closeDialog 2;
		[9] spawn Bizo_fnc_tablet;
	";
	
	_recruitAction = _recruitButton buttonSetAction "
		closeDialog 2;
		[10] spawn Bizo_fnc_tablet;
	";
	
	_suppliesAction = _suppliesButton buttonSetAction "
		closeDialog 2;
		[11] spawn Bizo_fnc_tablet;
	";
	
	_backAction = _backButton buttonSetAction "
		closeDialog 2;
		[1] spawn Bizo_fnc_tablet;
	";
	
	_homeAction = _homeButton buttonSetAction "
		closeDialog 2;
		[0] spawn Bizo_fnc_tablet;
	";
};

//SD - Quad
if(_displayType == 9) then {
	[0, _user] remoteExec ['Bizo_fnc_supplyDrop', 2];
};

//SD - Reinforcements
if(_displayType == 10) then {
	[1, _user] remoteExec ['Bizo_fnc_supplyDrop', 2];
};

//SD - Supplies
if(_displayType == 11) then {
	[2, _user] remoteExec ['Bizo_fnc_supplyDrop', 2];
};

//Groups
if(_displayType == 12) then {
	createDialog "TabletGroups";

	_groupsList = (findDisplay 4605) displayCtrl 4612;
	_playersList = (findDisplay 4605) displayCtrl 4613;
	_joinButton = (findDisplay 4605) displayCtrl 4614;
	_description = (findDisplay 4605) displayCtrl 4616;
	_homeButton = (findDisplay 4605) displayCtrl 4618;
	_backButton = (findDisplay 4605) displayCtrl 4619;
	
	
	
	[_user, _groupsList, _playersList, _description, _joinButton] spawn {
		_user = _this select 0;
		_groupsList = _this select 1;
		_playersList = _this select 2;
		_description = _this select 3;
		_joinButton = _this select 4;
		
		_allGroups = [];
		_groupUnits = [];
		
		while {dialog} do {
			lbClear _groupsList;
			_allGroups = _allGroups - _allGroups;
			{
				if(side _x == side _user && !(_x in _allGroups)) then {
					_allGroups pushBack _x;	
					_groupsList lbAdd (groupId _x);
				};
			}forEach allGroups;
			
			_selection = lbCurSel _groupsList;
			_selectionPlayers = lbCurSel _playersList;
			
			if(_selection != -1 && _selection < count _allGroups) then {
				_selectionText = _groupsList lbText _selection;
				_selectedGroup = [];

				{
					if(groupId _x == _selectionText) then {
						_selectedGroup = _x;
					};
				}forEach _allGroups;
			
				lbClear _playersList;
				_groupUnits = _groupUnits - _groupUnits;
				{
					if(!(_x in _groupUnits)) then {
						_groupUnits pushBack _x;	
						_playersList lbAdd (name _x);
					};
				}forEach (units _selectedGroup);
				
				_joinAction = _joinButton buttonSetAction format["
					_group = [];
					{if(groupId _x == %1)then{_group = _x};}foreach allGroups;
					[player] join _group;
				", str(groupId _selectedGroup)];
			};
			
			if(_selectionPlayers != -1 && _selectionPlayers < count _groupUnits) then {
				_selectionText = _playersList lbText _selectionPlayers;
				_selectedPlayer = objNull;

				if(count _groupUnits > 0) then {
					{
						if(name _x == _selectionText) then {
							_selectedPlayer = _x;
						};
					}forEach _groupUnits;
					
					_ammoCount = 0;
					_compatMags = [primaryWeapon player, true] call BIS_fnc_compatibleMagazines;

					{
						_currentMag = _x select 0;
						{if(_currentMag == _x)then{_ammoCount = _ammoCount + 1};}forEach _compatMags;
					}forEach (magazinesAmmo _selectedPlayer);

					_description ctrlSetStructuredText parseText format["<t size=""1"">Rank: %1<br/>Vitals Stable: %2<br/>Magazine Count: %3<br/>Has Medical Training: %4<br/>Has Engineer Training: %5</t>", rank _selectedPlayer, toUpper(str([player] call ace_medical_status_fnc_hasStableVitals)), _ammoCount, toUpper(str([_selectedPlayer] call ace_repair_fnc_isEngineer)), toUpper(str([_selectedPlayer] call ace_medical_treatment_fnc_isMedic))];
				} else {
					_description ctrlSetStructuredText parseText format["<t size=""1"">Rank: %1<br/>Vitals Stable: %2<br/>Magazine Count: %3<br/>Has Medical Training: %4<br/>Has Engineer Training: %5</t>", "", "", "", "", ""];
				};
			} else {
				_description ctrlSetStructuredText parseText format["<t size=""1"">Rank: %1<br/>Vitals Stable: %2<br/>Magazine Count: %3<br/>Has Medical Training: %4<br/>Has Engineer Training: %5</t>", "", "", "", "", ""];
			};

			sleep 0.25;
		};
	};
	
	
	
	_backAction = _backButton buttonSetAction "
		closeDialog 2;
		[1] spawn Bizo_fnc_tablet;
	";
	
	_homeAction = _homeButton buttonSetAction "
		closeDialog 2;
		[0] spawn Bizo_fnc_tablet;
	";
};

//Settings
if(_displayType == 13) then {
	createDialog "TabletSettings";

	_tracers = (findDisplay 4606) displayCtrl 4612;
	_ammo = (findDisplay 4606) displayCtrl 4613;
	_callsign = (findDisplay 4606) displayCtrl 4614;
	_homeButton = (findDisplay 4606) displayCtrl 4618;
	_backButton = (findDisplay 4606) displayCtrl 4619;
	
	_tracersAction = _tracers buttonSetAction "
		_currentSetting = player getVariable 'tracersOn';
		player setVariable ['tracersOn', !_currentSetting];
		systemChat format['[LOCAL]: Bullet Trajectory = %1', toUpper(str(!_currentSetting))];
		
		closeDialog 2;		
		[1] spawn Bizo_fnc_tablet;
	";
	
	_ammoAction = _ammo buttonSetAction "
		_currentSetting = player getVariable 'unlimitedAmmo';
		player setVariable ['unlimitedAmmo', !_currentSetting];
		systemChat format['[LOCAL]: Unlimited Ammo = %1', toUpper(str(!_currentSetting))];
	
		closeDialog 2;
		[1] spawn Bizo_fnc_tablet;
	";
	
	_callsignAction = _callsign buttonSetAction "
		closeDialog 2;
	";
	
	_backAction = _backButton buttonSetAction "
		closeDialog 2;
		[1] spawn Bizo_fnc_tablet;
	";
	
	_homeAction = _homeButton buttonSetAction "
		closeDialog 2;
		[0] spawn Bizo_fnc_tablet;
	";
};

//Settings
if(_displayType == 14) then {
	createDialog "TabletCallsign";

	_ok = (findDisplay 4607) displayCtrl 2600;
	_cancel = (findDisplay 4607) displayCtrl 2700;
	_edit = (findDisplay 4607) displayCtrl 4615;
	
	_okAction = _ok buttonSetAction format["
		(group player) setGroupIdGlobal [%1];
		
		closeDialog 2;
		[13] spawn Bizo_fnc_tablet;
	", ctrlText _edit];
	
	_cancelAction = _cancel buttonSetAction "
		closeDialog 2;
		[13] spawn Bizo_fnc_tablet;
	";
};