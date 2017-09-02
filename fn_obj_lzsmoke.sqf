_pos = param [0,[0,0,0],[[]],[2,3]];
_ply = param [1,objNull,[objNull]];
if !(isNull _ply) then {
	[_ply,format ["Pequod, this is %1, designate LZ by smoke grenade near grid: %2",_ply,mapGridPosition _pos]] remoteExec ["sideChat"];
};
if (!alive pequod_var_heli) exitWith {false};
[pequod_var_heli,'This is Pequod, on route to specified position.'] remoteExec ['sideChat'];
[] call pequod_fnc_clearobj;
_wp = group pequod_var_heli addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp2 = group pequod_var_heli addWaypoint [_pos, 1];
_wp2 setWaypointType "LOITER";
_wp2 setWaypointLoiterRadius 500;
pequod_var_heli flyinHeight 100;
group pequod_var_heli setCurrentWaypoint _wp;
_wp setWaypointStatements ["true","pequod_var_smoke='LZ'; [pequod_var_heli,'This is Pequod, standing by for smoke identification.'] remoteExec ['sideChat'];"];
true