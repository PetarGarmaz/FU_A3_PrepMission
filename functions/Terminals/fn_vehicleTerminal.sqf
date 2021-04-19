_terminal = _this param [0];
_terminalSpawn = _this param [1];
_terminalCallsign = _this param [2];
_isHarbor = _this param [3, false];
_harborSpawn = _this param [4, getMarkerPos _terminalSpawn];

_terminal setVariable ["showTerminal", true, true];

_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa'/> Opec's Vehicle Garage", {
	_nearVehicles = getMarkerPos (_this select 3 select 1) nearEntities [["Air", "Car", "Motorcycle", "Tank"], 30];
	
	[(_this select 0), ["OMComputerReboot", 20]] remoteExec ["say3D", 0]; 
	[(_this select 0), ["OMIntelGrabPC_02", 20]] remoteExec ["say3D", 0];
	
	(_this select 0) setVariable ["showTerminal", false, true];
	(_this select 0) animateSource["open_source", 0];
	
	if(count _nearVehicles == 0) then {
		[(_this select 3 select 1), side (_this select 1), (_this select 1), (_this select 3 select 3), (_this select 3 select 4)] call opec_fnc_garageNew;
		[format ["[SERVER]: %1 pulled a vehicle from %2.", name (_this select 1), (_this select 3 select 2)]] remoteExec ["systemChat",0];
	}
	else {
		["[SERVER]: Clear the spawn area!"] remoteExec ["systemChat",0];
	};
	
	(_this select 0) animateSource["open_source", 1];
	(_this select 0) setVariable ["showTerminal", true, true];
}, [_terminal, _terminalSpawn, _terminalCallsign, _isHarbor, _harborSpawn], 1.5, true, true, "", "(missionNamespace getVariable 'showTerminals') && (_target getVariable 'showTerminal') && isNull(_this getVariable 'personalVehicle')", 3];


_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\X_ca.paa'/> Remove your vehicle", {   
	(_this select 0) setVariable ["showTerminal", false, true];
	(_this select 0) animateSource["open_source", 0];
	
	[(_this select 0), ["OMComputerReboot", 20]] remoteExec ["say3D", 0]; 
	[(_this select 0), ["OMIntelGrabPC_02", 20]] remoteExec ["say3D", 0];

	deleteVehicle ((_this select 1) getVariable "personalVehicle");
	(_this select 1) setVariable ["personalVehicle", objNull, true];
	
	(_this select 0) animateSource["open_source", 1];
	(_this select 0) setVariable ["showTerminal", true, true];
}, nil, 1.5, true, true, "", "(_target getVariable 'showTerminal') && not(isNull(_this getVariable 'personalVehicle'))", 3];