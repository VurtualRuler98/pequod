_marker = param [0,"",[""]];

if (getMarkerColor _marker == "") exitWith {["Pequod marker-objectives must be a valid marker."] call bis_fnc_error;false};

if (!alive pequod_var_heli) exitWith {};

_txt = markerText _marker;


if (_txt=="Helicopter LZ") then {
	pequod_var_current_lz=nil;
	group pequod_var_heli setCombatMode pequod_var_roe;
	[pequod_var_heli,"This is Pequod, on route to specified LZ!"] remoteExec ["sideChat"];
	[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
	pequod_var_heli land "NONE";
	_wp = group pequod_var_heli addWaypoint [getmarkerpos _marker, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;
	pequod_var_heli flyinHeight 100;
	_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, on station at LZ!'] remoteExec ['sideChat']; pequod_var_heli land 'GET IN';"];
	group pequod_var_heli setCurrentWaypoint _wp;
};


if (_txt=="Helicopter Hover") then {
	pequod_var_current_lz=nil;
	group pequod_var_heli setCombatMode pequod_var_roe;
	[pequod_var_heli,'This is Pequod, on route to specified position!'] remoteExec ['sideChat'];
	[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
	pequod_var_heli land "NONE";
	_wp = group pequod_var_heli addWaypoint [getmarkerpos _marker, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 0;
	pequod_var_heli flyinHeight 100;
	_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, on station and holding position!'] remoteExec ['sideChat'];pequod_var_heli flyinHeight 6;"];
	group pequod_var_heli setCurrentWaypoint _wp;
};


if (_txt=="Helicopter RTB") then {
	pequod_var_current_lz=nil;
	group pequod_var_heli setCombatMode pequod_var_roe;
	[pequod_var_heli,'This is Pequod, returning to base!'] remoteExec ['sideChat'];
	[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
	pequod_var_heli land "NONE";
	_wp = group pequod_var_heli addWaypoint [getmarkerpos _marker, 0];
	_wp setWaypointType "MOVE";
	pequod_var_heli flyinHeight 100;
	_wp setWaypointStatements ["true","pequod_var_heli land 'LAND'; pequod_var_heli setDamage 0;"];
	group pequod_var_heli setCurrentWaypoint _wp;
};