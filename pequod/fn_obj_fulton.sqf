if (!alive pequod_var_heli) exitWith {true};

if (pequod_var_heli emptyPositions "cargo" == 0) exitWith {
	[pequod_var_heli,"This is Pequod, passenger space is full, can't recover fulton."] remoteExec ['sideChat'];
};

_chutes = nearestObjects [pequod_var_heli,["B_Parachute_02_F"],2000];
_chute = {if (_x getVariable "fulton_ischute") exitWith {_x}} forEach _chutes;

if (isnil '_chute') then {
	[pequod_var_heli,"This is Pequod, I can't see any fulton balloons."] remoteExec ['sideChat'];
} else {
	group pequod_var_heli setCombatMode "BLUE";
	[pequod_var_heli,'This is Pequod, recovering fulton!'] remoteExec ['sideChat'];
	[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
	pequod_var_heli land "NONE";
	_wp = group pequod_var_heli addWaypoint [getPos _chute, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;
	pequod_var_heli flyinHeight 100;
	group pequod_var_heli setCurrentWaypoint _wp;
};
true