_driver = driver pequod_var_heli;
_gunner = gunner pequod_var_heli;
[pequod_var_heli,"THIS IS PEQUOD, I'M GOING DOWN!"] remoteExec ['sideChat'];
sleep 10;
deleteVehicle _driver;
deleteVehicle _gunner;
[] call pequod_fnc_spawn;
true