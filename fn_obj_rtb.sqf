_ply = param [0,objNull,[objNull]];
if !(isNull _ply) then {
	[_ply,format ["Pequod, this is %1, RTB immediately.",_ply]] remoteExec ["sideChat"];
};
if (!alive pequod_var_heli) exitWith {false};
[pequod_var_heli,"This is Pequod, returning to base!"] remoteExec ["sideChat"];
[] call pequod_fnc_clearobj;
_wp = group pequod_var_heli addWaypoint [pequod_var_spawnpos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 10;
pequod_var_heli flyinHeight 100;
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, rearming now!'] remoteExec ['sideChat']; pequod_var_heli land 'LAND'; pequod_var_heli setDamage 0; pequod_var_heli setVehicleAmmo 1;"];
group pequod_var_heli setCurrentWaypoint _wp;
true