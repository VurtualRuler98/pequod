
pequod_var_heli = createVehicle [pequod_var_class,pequod_var_spawnpos,[],0,"FLY"];
publicVariable "pequod_var_heli";
createVehicleCrew pequod_var_heli;

pequod_var_heli setPosASL pequod_var_spawnpos;

pequod_var_heli addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
pequod_var_heli addEventHandler ["Killed",{[] spawn pequod_fnc_respawn}];
pequod_var_heli addAction ["Arsenal",{["Open",true] spawn bis_fnc_arsenal;}];

(driver pequod_var_heli) allowDamage false;
pequod_var_heli lockDriver true;
(gunner pequod_var_heli) allowDamage false;
pequod_var_heli lockTurret [[0],true];



_wp = group pequod_var_heli addWaypoint [pequod_var_spawnpos, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterRadius 500;
group pequod_var_heli setCurrentWaypoint _wp;

[pequod_var_heli,"This is Pequod, I have arrived at the AO."] remoteExec ['sideChat'];

true;