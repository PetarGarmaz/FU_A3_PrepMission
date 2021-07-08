params["_num", "_type"]; //Types: 0 = day numerical, 1 = month; 2 = day text;

_dayNumerical = ["st", "nd", "rd", "th"];
_daysArray = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
_months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
_output = "";

if(_type == 0) then {
	_lastNum = _num % 10;
	
	if(_num <= 10 || _num >= 14) then {
		if(_lastNum == 1) then {
			_output = format["%1%2", _num, _dayNumerical select 0];
		};
		
		if(_lastNum == 2) then {
			_output = format["%1%2", _num, _dayNumerical select 1];
		};
		
		if(_lastNum == 3) then {
			_output = format["%1%2", _num, _dayNumerical select 2];
		};
		
		if(_lastNum == 0 || _lastNum >= 4) then {
			_output = format["%1%2", _num, _dayNumerical select 3];
		};
	} else {
		_output = format["%1%2", _num, _dayNumerical select 3];
	};
};

if(_type == 1) then {
	{
		if(_forEachIndex == _num - 1) then {
			_output = _x;
		}
	}foreach _months;
};

if(_type == 2) then {
	private _year = date select 0;
	
	private _q = date select 2;
	private _m = date select 1;
	private _K = (_year % 100);
	private _J = (_year / 100);
	
	private _h = floor((_q + floor((13 * (_m + 1))/5) + _K + floor(_K/4) + floor(_J/4) - 2 * _J) % 7);
	
	{
		if(_forEachIndex == _h) then {
			_output = _x;
		}
	}foreach _daysArray;
};

_output;