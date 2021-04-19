_target = _this param [0, objNull];
_allArtilleryInArea = (missionNamespace getVariable 'mortars');

["[SERVER]: Enemy mortars incoming!"] remoteExec ["systemChat", 0];

sleep 20;

_targetPos = getPos _target;
_smoke = "SmokeShellRed" createVehicle _targetPos;

for "_i" from 1 to 3 do {
	{
		_x setVehicleAmmo 1;
		
		[_x, _targetPos]spawn {
			_roundPos = [(_this select 1), 10, 70, 0, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
			(_this select 0) doArtilleryFire [_roundPos, "8Rnd_82mm_Mo_shells", 1];
		};
		
		sleep 1;	
	}forEach _allArtilleryInArea;
	
	sleep 10;
};