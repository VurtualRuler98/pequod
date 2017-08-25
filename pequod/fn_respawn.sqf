_driver = driver pequod_var_heli;
_gunner = gunner pequod_var_heli;
[pequod_var_heli,"THIS IS PEQUOD, I'M GOING DOWN!"] remoteExec ['sideChat'];
sleep 10;
deleteVehicle _driver;
deleteVehicle _gunner;
[pequod_var_heli] spawn {
	sleep 30;
	deleteVehicle (_this select 0);
};
[] call pequod_fnc_spawn;
true