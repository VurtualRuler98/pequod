if (!alive pequod_var_heli) exitWith {true};

if (pequod_var_heli emptyPositions "cargo" == 0) exitWith {
	[pequod_var_heli,"This is Pequod, passenger space is full, can't recover fulton."] remoteExec ['sideChat'];
};
pequod_var_current_lz=nil;
_chutes = nearestObjects [pequod_var_heli,["B_Parachute_02_F"],5000];
_chute = {if (_x getVariable "fulton_ischute") exitWith {_x}} forEach _chutes;

if (isnil '_chute') then {
	[pequod_var_heli,"This is Pequod, I can't see any fulton balloons."] remoteExec ['sideChat'];
} else {
	pequod_var_current_lz=nil;
	group pequod_var_heli setCombatMode pequod_var_roe;
	[pequod_var_heli,'This is Pequod, recovering fulton!'] remoteExec ['sideChat'];
	[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
	pequod_var_heli land "NONE";
	_pos = getPosASL _chute;
	_dir = [pequod_var_heli,_pos] call bis_fnc_relativeDirTo;
	_wp = group pequod_var_heli addWaypoint[[(_pos select 0)-200*sin(_dir),(_pos select 1)-200*cos(_dir),_pos select 2],0];
	_wp setWaypointType "MOVE";
	_wp setWaypointTimeout [5,5,5];


	_wp2 = group pequod_var_heli addWaypoint [[(_pos select 0)+200*sin(_dir),(_pos select 1)+200*cos(_dir),_pos select 2],1];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointTimeout [5,5,5];

	_wp3 = group pequod_var_heli addWaypoint [_pos, 2];
	_wp3 setWaypointType "LOITER";
	_wp3 setWaypointLoiterRadius 500;
	pequod_var_heli flyinHeight 100;
	group pequod_var_heli setCurrentWaypoint _wp;
};
true