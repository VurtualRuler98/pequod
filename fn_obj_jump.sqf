_pos = param [0,[0,0,0],[[]],[2,3]];

if (!alive pequod_var_heli) exitWith {true};
[] call pequod_fnc_clearobj;
[pequod_var_heli,'This is Pequod, heading to specified coordinates.'] remoteExec ['sideChat'];
_wp = group pequod_var_heli addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 10;
pequod_var_heli flyinHeight 1000;
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, I have arrived at marker, prepare for jumping!'] remoteExec ['sideChat']"];

_wp2 = group pequod_var_heli addWaypoint [_pos, 1];
_wp2 setWaypointType "LOITER";
_wp2 setWaypointLoiterRadius 500;
group pequod_var_heli setCurrentWaypoint _wp;

true
