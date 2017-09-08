_pos = param [0,[0,0,0],[[]],[2,3]];
_ply = param [1,objNull,[objNull]];
if !(isNull _ply) then {
	[_ply,format ["Pequod, this is %1, designate LZ by coordinates near grid: %2",_ply,mapGridPosition _pos]] remoteExec ["sideChat"];
};
if (!alive pequod_var_heli) exitWith {false};
[pequod_var_heli,"This is Pequod, on route to specified LZ!"] remoteExec ["sideChat"];
[] call pequod_fnc_clearobj;
_wp = group pequod_var_heli addWaypoint [_pos, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 10;
pequod_var_heli flyinHeight 100;
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, on station at LZ!'] remoteExec ['sideChat']; pequod_var_heli land 'GET IN';"];
group pequod_var_heli setCurrentWaypoint _wp;
true