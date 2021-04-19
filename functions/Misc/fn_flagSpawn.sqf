_flag = _this param [0];
_sidePL = _this param [1];
_civFlag = _this param [2, false];


if(_civFlag) then {
	_flag addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\K_ca.paa'/> Teleport to Chernogorsk", { 
		titleCut ["", "BLACK FADED", 40]; 
		(_this select 1) allowDamage false; 
		
		[  
			[  
				["TELEPORTING TO: Kavala", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
			], 0, 0.5  
		] spawn BIS_fnc_typeText; 
	  
		(_this select 1) setPosASL (getPosASL flagCherno); 
	  
		sleep 5; 
		titleCut ["", "BLACK IN", 5]; 
		(_this select 1) allowDamage true; 
	}, nil, 1.5, true, true, "", "true", 3];
	
	_flag addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\I_ca.paa'/> Teleport to IDAP Camp", { 
		titleCut ["", "BLACK FADED", 40]; 
		(_this select 1) allowDamage false; 
		
		[  
			[  
				["TELEPORTING TO: IDAP Camp", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
			], 0, 0.5  
		] spawn BIS_fnc_typeText; 
	  
		(_this select 1) setPosASL (getPosASL flagIDAP); 
	  
		sleep 5; 
		titleCut ["", "BLACK IN", 5]; 
		(_this select 1) allowDamage true; 
	}, nil, 1.5, true, true, "", "true", 3];
	
	_flag addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\F_ca.paa'/> Teleport to Freedom of Speech Radio Station", { 
		titleCut ["", "BLACK FADED", 40]; 
		(_this select 1) allowDamage false; 
		
		[  
			[  
				["TELEPORTING TO: Freedom of Speech Radio Station", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
			], 0, 0.5  
		] spawn BIS_fnc_typeText; 
	  
		(_this select 1) setPosASL (getPosASL flagFOSR); 
	  
		sleep 5; 
		titleCut ["", "BLACK IN", 5]; 
		(_this select 1) allowDamage true; 
	}, nil, 1.5, true, true, "", "true", 3];
	
	_flag addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\P_ca.paa'/> Teleport to Pilot School", { 
		titleCut ["", "BLACK FADED", 40]; 
		(_this select 1) allowDamage false; 
		
		[  
			[  
				["TELEPORTING TO: Pilot School", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
			], 0, 0.5  
		] spawn BIS_fnc_typeText; 
	  
		(_this select 1) setPosASL (getPosASL flagSchool); 
	  
		sleep 5; 
		titleCut ["", "BLACK IN", 5]; 
		(_this select 1) allowDamage true; 
	}, nil, 1.5, true, true, "", "true", 3];
}
else {
	_flag addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa'/> Teleport to your Leader", { 
		_PL = objNull;
		
		if(side (_this select 1) == west) then {_PL = PL_WEST};
		if(side (_this select 1) == east) then {_PL = PL_EAST};
		if(side (_this select 1) == resistance) then {_PL = PL_GUER};
		
		titleCut ["", "BLACK FADED", 40]; 
		(_this select 1) allowDamage false; 
	  
		if(leader group (_this select 1) == (_this select 1)) then { 
			[  
				[  
					["TELEPORTING TO:", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30], 
					[format["%1", name _PL], "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
				], 0, 0.5  
			] spawn BIS_fnc_typeText; 
		   
			if(vehicle _PL != _PL) then { 
				(_this select 1) moveInCargo (vehicle _PL);  
			}
			else { 
				(_this select 1) setPosASL (getPosASL _PL);  
			}; 
		}
		else { 
			[  
				[  
					["TELEPORTING TO:", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30], 
					[format["%1", name (leader group (_this select 1))], "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
				], 0, 0.5  
			] spawn BIS_fnc_typeText; 
	   
			if(vehicle (leader group (_this select 1)) != leader group (_this select 1)) then { 
				(_this select 1) moveInCargo (vehicle (leader group (_this select 1))); 
			} else { 
				(_this select 1) setPosASL (getPosASL leader group (_this select 1)); 
			}; 
		}; 
	  
		sleep 5; 
		titleCut ["", "BLACK IN", 5]; 
		(_this select 1) allowDamage true; 
	}, nil, 1.5, true, true, "", "true", 3];

	_flag addAction["<img image='\A3\ui_f_orange\data\cfgTaskTypes\airdrop_ca.paa'/> Paradrop", { 
		[(_this select 1)] spawn Bizo_fnc_haloDrop;
	}, nil, 1.5, true, true, "", "true", 3];

};

_flag addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa'/> Skip Time (4h)", { 
		[4]remoteExec["skipTime", 2];
	}, nil, 1.5, true, true, "", "true", 3];