_weaponStand = _this param [0];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\A_ca.paa'/> Autorifleman", {
	_unitLoadout = [side (_this select 1), "AR"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\B_ca.paa'/> Crewman", {
	_unitLoadout = [side (_this select 1), "Crew"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\C_ca.paa'/> Engineer", {
	_unitLoadout = [side (_this select 1), "Engi"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa'/> Heavy Gunner", {
	_unitLoadout = [side (_this select 1), "HG"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\E_ca.paa'/> Marksman", {
	_unitLoadout = [side (_this select 1), "Mark"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\F_ca.paa'/> Medic", {
	_unitLoadout = [side (_this select 1), "Med"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\G_ca.paa'/> Pilot (Helicopter)", {
	_unitLoadout = [side (_this select 1), "Pilot_H"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\H_ca.paa'/> Pilot (Plane)", {
	_unitLoadout = [side (_this select 1), "Pilot_P"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\I_ca.paa'/> Rifleman", {
	_unitLoadout = [side (_this select 1), "Rifle"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\J_ca.paa'/> Rifleman (LAT)", {
	_unitLoadout = [side (_this select 1), "LAT"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\K_ca.paa'/> Rifleman (MAT)", {
	_unitLoadout = [side (_this select 1), "MAT"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];

_weaponStand addAction["<img image='\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa'/> Squad Leader", {
	_unitLoadout = [side (_this select 1), "SL"] call Bizo_fnc_getLoadout;
	(_this select 1) setUnitLoadout _unitLoadout;
}, nil, 1.5, true, true, "", "true", 3];