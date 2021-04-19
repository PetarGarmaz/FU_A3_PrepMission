dropper = _this param [0];

hint "Press Left Mouse Button on a position where you want to HALO drop...";

openMap true;

haloDropHandle = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseButtonClick",{
	params ["_displayorcontrol", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];

	_drop = [dropper] spawn {
		_dropper = _this select 0;
		
		hint "You will be dropped in 10 seconds, get ready...";
	
		_haloPos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
		
		sleep 0.5;
		
		_marker = createMarker ["haloDropMarker", _haloPos];
		"haloDropMarker" setMarkerText format["%1's Drop Zone", name _dropper, 0, _dropper];
		"haloDropMarker" setMarkerPos _haloPos;
		"haloDropMarker" setMarkerType "hd_end";
		
		sleep 0.5;
		
		_haloPos = [
			(_haloPos select 0),
			(_haloPos select 1),
			3000
		];
		
		openMap false;
		
		sleep 1;

		//Adding equipment
		_currentBackpack = typeOf (unitBackpack _dropper);
		_currentBackpackInv = backpackItems _dropper;
		
		sleep 1;
		
		removeBackpackGlobal _dropper;
		[_dropper, _currentBackpack] call zade_boc_fnc_addChestpack;
		
		{
			[_dropper, _x] call zade_boc_fnc_addItemToChestpack;
		} forEach _currentBackpackInv;  
		
		sleep 1;
		
		_dropper addBackpackGlobal "B_Parachute";
		
		sleep 6;
		
		titleCut ["", "BLACK FADED", 40];
		
		[  
			[  
				["HALO DROPPING ABOVE:", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30], 
				[format["%1", markerText "haloDropMarker"], "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 30] 
			], 0, 0.5 
		] spawn BIS_fnc_typeText;

		//Dropping
		_dropper setPos _haloPos;

		sleep 4;
		titleCut ["", "BLACK IN", 5];
		
		sleep 10;
		
		deleteMarker "haloDropMarker";
	};
	
	(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["MouseButtonClick", haloDropHandle];
}];

