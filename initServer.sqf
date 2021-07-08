missionNamespace setVariable ["showTerminals", true, true];
missionNamespace setVariable ["showArsenals", true, true];

addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	
	if(isPlayer _instigator) then {
		_currentKills = _instigator getVariable "totalKills";
		_instigator setVariable ["totalKills", _currentKills + 1, true];
	};
}];

//SafeZone - no explosives script
_safeZone = [] spawn {
	_safeZones = [];
	{if("SafeZone" in _x) then {_safeZones pushBack _x}}forEach allMapMarkers;

	{
		[_x] spawn {
			_marker = _this select 0;

			while {_marker in allMapMarkers} do {
				_radius = (getMarkerSize _marker) select 0;

				{
					_distance = (getMarkerPos _marker) distance (getPos _x);

					if(_distance <= _radius) then {deleteVehicle _x};
				}foreach allMines;
				
				sleep 4;
			};
		};
	}foreach _safeZones;
};
