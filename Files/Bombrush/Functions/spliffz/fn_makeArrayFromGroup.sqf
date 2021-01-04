_grp = _this select 0;
_array = [];
{
		_array set [(count _array), _x];
} foreach units _grp;

_array