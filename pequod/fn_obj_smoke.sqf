_smoke = param [0,"smokeShell",[""]];

if (!alive pequod_var_heli) exitWith {true};

_shell = pequod_var_heli nearObjects[_smoke,500] select 0;

if (isNil '_shell') then {
	[pequod_var_heli,"This is Pequod, I can't see the smoke you've specified."] remoteExec ['sideChat'];
} else {
	pequod_var_current_lz=nil;
	group pequod_var_heli setCombatMode pequod_var_roe;
	[pequod_var_heli,'This is Pequod, on route to specified LZ.'] remoteExec ['sideChat'];
	[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
	pequod_var_heli land "NONE";
	_wp = group pequod_var_heli addWaypoint [getPos _shell, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;
	pequod_var_heli flyinHeight 100;
	_lz = "Land_HelipadEmpty_F" createVehicle (getPos _shell);
	_lz setPosASL getPosASL _shell;
	_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, on station at LZ!'] remoteExec ['sideChat']; pequod_var_heli land 'GET IN';"];
	group pequod_var_heli setCurrentWaypoint _wp;
	pequod_var_current_lz=_lz;
	[_lz] spawn {
		_lz=_this select 0;
		waitUntil {_lz distance pequod_var_heli<4 || pequod_var_current_lz!=_lz};
		sleep 4;
		hint "DELET THIS";
		deleteVehicle _lz;
	};
};
true