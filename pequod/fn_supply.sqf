_cargo = "CargoNet_01_box_F" createVehicle (getPosATL pequod_var_heli);
_cargo setPosATL [(getPosATL pequod_var_heli) select 0, (getPosATL pequod_var_heli) select 1, ((getPosATL pequod_var_heli) select 2)-5];
_cargo addAction ["Arsenal",{["Open",true] spawn bis_fnc_arsenal;}];

[_cargo,
"Dispose of supplies",
"",
"",
"isNull attachedTo _target",
"true",
{},
{},
{[_this select 0] remoteExec ["pequod_fnc_fulton_delete",_this select 0]},
{},
[],
3,
0,
false,
false ] call bis_fnc_holdActionAdd;


[_cargo] spawn {
	sleep 1;
	_cargo = _this select 0;
	_veh = "B_Parachute_02_F" CreateVehicle getPosATL _cargo;
	_veh setPosATL [(getPosATL _cargo) select 0, (getPosATL _cargo) select 1, ((getPosATL _cargo) select 2)];
	_cargo attachTo [_veh,[0,0,-10]];
	WaitUntil {((((position _cargo) select 2) < 0.6) || (isNull _veh))};
	detach _cargo;
	_cargo SetVelocity [0,0,-5];           
	sleep 0.3;

	_cargo setPos [(position _cargo) select 0, (position _cargo) select 1, 1];
	_cargo SetVelocity [0,0,0];
};