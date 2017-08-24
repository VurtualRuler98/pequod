[] spawn {
	for "_i" from 1 to 10 do {
		_veh = "smokeShell" CreateVehicle getPosATL pequod_var_heli;
		_veh setPosATL [(getPosATL pequod_var_heli) select 0, (getPosATL pequod_var_heli) select 1, ((getPosATL pequod_var_heli) select 2)-5];
		_veh SetVelocity [(random 10)-5,(random 10)-5,0];
		sleep 0.05;
	};
};
true