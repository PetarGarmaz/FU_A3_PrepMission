_terminal = _this param [0];

_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa'/> Enable/Disable Vehicle Terminals", {
	_terminalStatus = missionNamespace getVariable "showTerminals";

	[(_this select 0), ["OMComputerReboot", 20]] remoteExec ["say3D", 0]; 
	[(_this select 0), ["OMIntelGrabPC_02", 20]] remoteExec ["say3D", 0];
	
	(_this select 0) animateSource["open_source", 0];
	
	missionNamespace setVariable ["showTerminals", !_terminalStatus, true];
	
	[format["Enabled Terminals Status: %1", toUpper(str !_terminalStatus)]] remoteExec ["systemChat", 0, true];
	(_this select 0) animateSource["open_source", 1];
}, nil, 1.5, true, true, "", "true", 3];

_terminal addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa'/> Enable/Disable Arsenals", {
	_arsenalStatus = missionNamespace getVariable "showArsenals";
	_allArsenals = (getMarkerPos "mapCenter") nearEntities ["B_CargoNet_01_ammo_F", 8000];

	[(_this select 0), ["OMComputerReboot", 20]] remoteExec ["say3D", 0]; 
	[(_this select 0), ["OMIntelGrabPC_02", 20]] remoteExec ["say3D", 0];
	
	(_this select 0) animateSource["open_source", 0];
	
	{
		[_x, _arsenalStatus] remoteExec ["hideObjectGlobal", 2];
	}forEach _allArsenals;
	
	missionNamespace setVariable ["showArsenals", !_arsenalStatus, true];
	
	[format["Enabled Arsenal Status: %1", toUpper(str !_arsenalStatus)]] remoteExec ["systemChat", 0, true];
	(_this select 0) animateSource["open_source", 1];
}, nil, 1.5, true, true, "", "true", 3];