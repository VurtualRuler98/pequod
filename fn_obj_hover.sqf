_pos = param [0,[0,0,0],[[]],[2,3]];

if (!alive pequod_var_heli) exitWith {true};
[] call pequod_fnc_clearobj;
[pequod_var_heli,'This is Pequod, heading to specified coordinates for low hover.'] remoteExec ['sideChat'];
_wp = group pequod_var_heli addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 10;
pequod_var_heli flyinHeight 100;
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, I have arrived at marker, descending!'] remoteExec ['sideChat']; pequod_var_heli flyinHeight 5"];

group pequod_var_heli setCurrentWaypoint _wp;

true
