_pos = param [0,[0,0,0],[[]],[2,3]];
_ply = param [1,objNull,[objNull]];
if !(isNull _ply) then {
	[_ply,format ["Pequod, this is %1, CAS requested, fire support at grid: %2",_ply,mapGridPosition _pos]] remoteExec ["sideChat"];
};
if (!alive pequod_var_heli) exitWith {true};

[] call pequod_fnc_clearobj;
[pequod_var_heli,"This is Pequod, I'm coming in hot, find cover!"] remoteExec ['sideChat'];


_wp = group pequod_var_heli addWaypoint [_pos, 0];
_wp setWaypointType "SAD";
pequod_var_heli flyinHeight 100;

group pequod_var_heli setCombatMode "RED";
group pequod_var_heli setCurrentWaypoint _wp;
true
