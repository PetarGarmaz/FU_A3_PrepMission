params ["_player", "_didJIP"];

player setVariable ["loadout", getUnitLoadout _player];
player setVariable ["totalKills", 0, true];
player setVariable ["shotsFired", 0];
player setVariable ["maxLifeTime", 0];

player setVariable ["tracersOn", false];
player setVariable ["unlimitedAmmo", false];

//SafeZone script
_safeZone = [] spawn {
	_safeZones = [];
	{if("SafeZone" in _x) then {_safeZones pushBack _x}}forEach allMapMarkers;

	while {true} do {
		_nearestSafeZone = [_safeZones, getPos player] call BIS_fnc_nearestPosition;
		_baseName = markerText _nearestSafeZone;
		_distance = (getMarkerPos _nearestSafeZone) distance (getPos player);
		
		if(_distance <= 200 && isDamageAllowed player) then {
			player allowDamage false;
			hint format["You have entered the %1 safe zone.", _baseName];
		};
		
		if(_distance >= 200 && !isDamageAllowed player) then {
			player allowDamage true;
			hint format["You have exited the %1 safe zone.", _baseName];
		};
		
		sleep 2;
	};
};

//No bullets in safezone
player addEventHandler ["Fired", { 
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	_bulletsSafezone = [_projectile] spawn {
		_projectile = _this select 0;
		_safeZones = [];

		{if("SafeZone" in _x) then {_safeZones pushBack _x}}forEach allMapMarkers;

		while {alive _projectile} do {
			_nearestSafeZone = [_safeZones, getPos _projectile] call BIS_fnc_nearestPosition;
			_baseName = markerText _nearestSafeZone;
			_distance = (getMarkerPos _nearestSafeZone) distance (getPos _projectile);
			
			if(_distance <= 300) then {
				deleteVehicle _projectile;
			};
		};
	};
}];

//Tablet Action
_tabletScript = {
	[0] spawn Bizo_fnc_tablet;
};

_tabletAction = [
	"Open FU Tablet",
	"FU Tablet",
	"\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa",
	_tabletScript,
	{true}
] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _tabletAction] call ace_interact_menu_fnc_addActionToObject;

//Shots Fired stat
_player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	
	_shotsFired = _unit getVariable "shotsFired";

	_unit setVariable ["shotsFired", _shotsFired + 1];
}];

//Lifetime stat
[] spawn {
	_lifetime = 0;

	while {true} do {
		_maxLifeTime = player getVariable "maxLifeTime";
	
		if(alive player) then {
			_lifetime = _lifetime + 1;
			
			if(_lifetime > _maxLifeTime) then {
				_maxLifeTime = _lifetime;
			};
		} else {
			_lifetime = 0;
		};
		
		sleep 1;
		player setVariable ["maxLifeTime", _maxLifeTime];
	};
};

//Unlimited Ammo
player addEventHandler ["Fired", { 
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	if(_unit getVariable "unlimitedAmmo") then {
		_unit setVehicleAmmo 1;
	};
}];

//Bullet Trajectory
[] spawn {
	_switch = false;

	while {alive player} do {
		if(player getVariable "tracersOn" && !_switch) then {
			[player] spawn BIS_fnc_traceBullets;
			_switch = true;
		};
		
		if(!(player getVariable "tracersOn") && _switch) then {
			[player, 0] spawn BIS_fnc_traceBullets;
			_switch = false;
		};
	};
};

//Create briefing - Subject
player createDiarySubject ["prep_mission", "Mission Guides", "\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa"];

//Create briefing entries
player createDiaryRecord [
	"prep_mission", 
	[
		"FU Tablet Guide",
		"<font size='15' face='TahomaB'>TABLE OF CONTENTS:</font><br/>
		1. General information<br/>
		2. Lock screen<br/>
		3. Home screen<br/>
		4. Player stats<br/>
		5. Virtual garage<br/>
		6. Missions<br/>
		7. Supplies/Reinforcements<br/>
		8. Groups<br/>
		9. Player settings<br/><br/>
		
		<font size='15' face='TahomaB'>GENERAL INFORMATION:</font><br/>
		FU Tablet, or FUT, is a small tool every soldier has at their disposal. It has couple different menus that offer the overview of one's stats or a certain functionality, like accepting missions, accessing virtual garage, calling for reinforcements or a supply drop.<br/><br/>To open your tablet, do self interaction (CTRL + WINDOWS KEY), go to Equipment and select FU Tablet. To close the tablet, just press ESC.<br/><br/>
		
		<font size='15' face='TahomaB'>LOCK SCREEN:</font><br/>
		Lock screen contains basic information one soldier would need, like time, date, weather, temperature and current location. To unlock your tablet, press HOME button on the tablet (little house icon on the bottom).<br/><br/>
		
		<font size='15' face='TahomaB'>HOME SCREEN:</font><br/>
		This is the Main menu of the tablet. You can access all the functionalities of the tablet from here. To go back to Lock screen, press HOME button again.
		
		"
	]
];