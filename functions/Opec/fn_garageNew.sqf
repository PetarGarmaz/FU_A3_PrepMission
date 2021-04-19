disableSerialization;

uiNamespace setVariable [ "current_garage", (_this select 0)];

_marker = uiNamespace getVariable "current_garage";

_fullVersion = missionNamespace getVariable [ "BIS_fnc_arsenal_fullGarage", false];

_pullerSide = _this param [1];
_puller = _this param [2];
_isHarbor = _this param [3, false];
_harborSpawn = _this param [4, getMarkerPos (_this select 0)];

if !( isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] ) ) exitwith {
	"Garage Viewer is already running" call bis_fnc_logFormat;
};

{
	deleteVehicle _x;
} forEach nearestObjects [ getMarkerPos _marker, [ "AllVehicles" ], 10];

_veh = createVehicle [ "Land_HelipadEmpty_F", getMarkerPos _marker, [], 0, "CAN_COLLIDE" ];
uiNamespace setVariable [ "garage_pad", _veh];
missionNamespace setVariable [ "BIS_fnc_arsenal_fullGarage", [ true, 0, false, [ false ] ] call bis_fnc_param ];

with missionNamespace do { 
	BIS_fnc_garage_center = [ true, 1, _veh, [ objNull ] ] call bis_fnc_param; 
};

with uiNamespace do {  
	_displayMission = [] call ( uiNamespace getVariable "bis_fnc_displayMission" );
	
	if !( isNull findDisplay 312 ) then {
		_displayMission = findDisplay 312; 
	};
	
	_displayMission createDisplay "RscDisplayGarage";
	uiNamespace setVariable [ "running_garage", true ];
	
	waitUntil {
		sleep 1.5; isNull ( uiNamespace getVariable [ "BIS_fnc_arsenal_cam", objNull ] ) 
	};
	
	_marker = uiNamespace getVariable "current_garage";
	_pad = uiNamespace getVariable "garage_pad";
	deleteVehicle _pad;
	sleep 1;
	
	_veh_list = ( getMarkerPos _marker ) nearEntities 25;
	
	{
		_vehType = typeOf _x;
		_textures = getObjectTextures _x;
		
		_crew = crew _x;
		{
			_x spawn { 
				_this action [ "Eject", vehicle _this ];
				sleep ( random 5 );
				deleteVehicle _this;
			};
			
		} forEach _crew;
		
		deleteVehicle _x;
		
		sleep 1;
		
		_new_veh = createVehicle [ _vehType, _harborSpawn, [], 0, "NONE" ];
		_new_veh setPosATL [ ( position _new_veh select 0 ), ( position _new_veh select 1 ), 0.25 ];
		_vehDir = markerDir _marker;
		_new_veh setDir _vehDir;
		_objecttype = _new_veh call BIS_fnc_objectType;
		sleep 0.25;
		
		_puller moveInDriver _new_veh;
		
		if(_objecttype select 0 == "VehicleAutonomous") then {
			_uavObject = createVehicleCrew _new_veh;
			_new_veh joinAs [createGroup _pullerSide, 0];
		};
		
		if((not _isHarbor && _objecttype select 1 == "Ship") || (not _isHarbor && _objecttype select 1 == "Submarine")) then {
			deleteVehicle _new_veh;
			[format["[SERVER]: And just what are you going to do with that %1, %2? Push it to the fucking sea or something?", toLower (_objecttype select 1), name _puller]] remoteExec ["systemChat",0];
		};
		
		_count = 0;
		
		{
			_new_veh setObjectTexture [ _count, _x ];
			_count = _count + 1;
		} forEach _textures;
		
		_puller setVariable ["personalVehicle", _new_veh, true];
		
		[_puller, _new_veh] spawn {
			_puller = _this select 0;
			_new_veh = _this select 1;
			
			while {true} do {
				if(!alive _new_veh) exitwith {
					_puller setVariable ["personalVehicle", objNull, true];
				};
			};
		};
	} forEach _veh_list;
};