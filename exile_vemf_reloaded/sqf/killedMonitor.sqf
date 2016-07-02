/*
	Author: IT07

	Description:
	will loop until all given objects are dead

	Params:
	_this select 0: ARRAY - array of objects to monitor

	Returns:
	nothing
*/

_a = param [0,[],[[]]];
if ((count _a) > 0) then
	{
		_k = 0;
		_cnt = count _a;
		_kp = round(("killPercentage" call VEMFr_fnc_config)/100*_cnt);
		while {true} do
			{
				scopeName "while";
				_k = 0;
				{
					if (((damage _x) isEqualTo 1) OR (isNull _x)) then { _k = _k + 1 };
				} forEach _a;
				if (_k < _kp) then
					{
						uiSleep 3;
					} else
					{
						breakOut "while";
					};
			};
	};
