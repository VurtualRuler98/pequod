pequod_var_current_lz=nil;
group pequod_var_heli setCombatMode pequod_var_roe;
[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
pequod_var_heli land "NONE";
pequod_var_heli flyInHeight 100;