_plat = _this select 0;
_height = _this select 1;
_plat addAction ["Elevator",{
	_veh = _this select 1;
	_veh = vehicle _veh;
	_height = _this select 3 select 0;
	_veh setPosASL [getPosASL _veh select 0, getPosASL _veh select 1, (getPosASL _veh select 2)+_height];
},[_height]];
