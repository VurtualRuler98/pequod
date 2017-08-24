_veh = param [0,objNull,[objNull]];

if (isNull _veh || not (_veh isKindOf "Helicopter")) exitWith {["Pequod must be a valid helicopter"] call bis_fnc_error; false};

pequod_var_class = typeOf _veh;
pequod_var_spawnpos = [getPosASL _veh select 0,getPosASL _veh select 1,(getPosASL _veh select 2)+100];

deleteVehicle _veh;
[] call pequod_fnc_spawn;

[] spawn {
	while {true} do {
		sleep 60;
		if (alive pequod_var_heli) then {
			pequod_var_heli setFuel 1;
		};
	};
};

true