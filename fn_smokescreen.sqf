_pos = param [0,nil,[[]],[2,3]];
if (isNil "_pos") then {_pos = getPosATL pequod_var_heli;};
[_pos] spawn {
	_pos = _this select 0;
	for "_i" from 1 to 10 do {
		_veh = "smokeShell" CreateVehicle _pos;
		_veh setPosATL [_pos select 0, _pos select 1, ((getPosATL pequod_var_heli) select 2)-5];
		_veh SetVelocity [(random 10)-5,(random 10)-5,0];
		sleep 0.05;
	};
};
true