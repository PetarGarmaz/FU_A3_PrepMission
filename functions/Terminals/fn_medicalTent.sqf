_box = _this param [0];

_box addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa'/> Heal yourself and everyone around you", {   
	(_this select 0) animateSource["cover", 1]; 
	sleep 1;
	
	[(_this select 1), ["OMIntelGrabBody_01", 20]] remoteExec ["say3D", 0];
	sleep 1;
	[(_this select 1), ["OMIntelGrabBody_02", 20]] remoteExec ["say3D", 0];
	sleep 1;
	[(_this select 1), ["OMIntelGrabBody_03", 20]] remoteExec ["say3D", 0];

	_peopleToBeHealed = (getPos (_this select 1)) nearEntities ["Man", 10];

	{
		[_x] call ace_medical_treatment_fnc_fullHealLocal;
	} forEach _peopleToBeHealed;

	systemChat "[SERVER]: You have been healed!";
	(_this select 0) animateSource["cover", 0];
}, nil, 1.5, true, true, "", "true", 3];