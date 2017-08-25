_pos = param [0,[0,0,0],[[]],[2,3]];

if (!alive pequod_var_heli) exitWith {true};

[pequod_var_heli,'This is Pequod, heading to specified coordinates.'] remoteExec ['sideChat'];
pequod_var_current_lz=nil;
group pequod_var_heli setCombatMode pequod_var_roe;
[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
pequod_var_heli land "NONE";

_wp = group pequod_var_heli addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 10;
pequod_var_heli flyinHeight 100;
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, I have arrived at marker!'] remoteExec ['sideChat'];"];

_wp2 = group pequod_var_heli addWaypoint [_pos, 1];
_wp2 setWaypointType "LOITER";
_wp2 setWaypointLoiterRadius 500;
group pequod_var_heli setCurrentWaypoint _wp;
true
