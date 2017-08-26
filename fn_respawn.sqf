[pequod_var_heli,"THIS IS PEQUOD, I'M GOING DOWN!"] remoteExec ['sideChat'];
sleep 10;
{deleteVehicle _x} forEach pequod_var_crew;
[pequod_var_heli] spawn {
	sleep 30;
	deleteVehicle (_this select 0);
};
[] call pequod_fnc_spawn;
true