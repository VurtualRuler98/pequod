_pos = param [0,nil,[[]],[2,3]];
if (isNil "_pos") then {_pos = getPosATL pequod_var_heli;};
_cargo = "CargoNet_01_box_F" createVehicle (getPosATL pequod_var_heli);
_cargo setPosATL [_pos select 0, _pos select 1, ((getPosATL pequod_var_heli) select 2)-5];
[_cargo] remoteExec ["pequod_fnc_addaction_supply",0,_cargo call bis_fnc_netid];
if (pequod_var_spawnpoint) then {
	[missionNamespace,_cargo,"Supply drop"] call bis_fnc_addRespawnPosition;
};
[_cargo,_cargo call bis_fnc_netid] spawn {
	params ["_cargo","_id"];
	waitUntil { isNull _cargo };
	remoteExec ["",_id];
};
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
	_cargo SetVelocity [0,0,0];
};