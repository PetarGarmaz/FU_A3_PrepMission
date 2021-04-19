params ["_player", "_didJIP"];

//SafeZone script
_safeZone = [_player] spawn {
	_player = _this select 0;
	_safeZones = [];
	{if("SafeZone" in _x) then {_safeZones pushBack _x}}forEach allMapMarkers;

	while {true} do {
		_nearestSafeZone = [_safeZones, getPos _player] call BIS_fnc_nearestPosition;
		_baseName = markerText _nearestSafeZone;
		_distance = (getMarkerPos _nearestSafeZone) distance (getPos _player);
		
		if(_distance <= 200 && isDamageAllowed _player) then {
			_player allowDamage false;
			hint format["You have entered the %1 safe zone.", _baseName];
		};
		
		if(_distance >= 200 && !isDamageAllowed _player) then {
			_player allowDamage true;
			hint format["You have exited the %1 safe zone.", _baseName];
		};
		
		sleep 2;
	};
};