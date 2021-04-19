_operationName = _this param [0, "Default Name"];
_randomMusic = selectRandom["LeadTrack01_F_Bootcamp", "LeadTrack01_F", "LeadTrack02_F", "AmbientTrack01_F", "LeadTrack01_F_Mark", "LeadTrack01_F_EXP", "EventTrack01_F_Jets", "LeadTrack01_F_Orange", "LeadTrack05_F_Tank"];

1 fadeSound 0;
playMusic _randomMusic;
titleCut ["", "BLACK FADED", 40];

[ 
	[ 
		[format["OPERATION: %1", _operationName], "<t align = 'right' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>", 50]
	], 0.7, 1
] spawn BIS_fnc_typeText;

sleep 5;

titleCut ["", "BLACK IN", 5];
5 fadeSound 1;