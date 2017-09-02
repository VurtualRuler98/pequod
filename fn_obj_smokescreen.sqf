_pos = param [0,[0,0,0],[[]],[2,3]];
_ply = param [1,objNull,[objNull]];
if !(isNull _ply) then {
	[_ply,format ["Pequod, this is %1, CAS requested, smokescreen at grid: %2",_ply,mapGridPosition _pos]] remoteExec ["sideChat"];
};
if (!alive pequod_var_heli) exitWith {true};
[] call pequod_fnc_clearobj;
[pequod_var_heli,'This is Pequod, preparing to deploy smokescreen at the specified coordinates.'] remoteExec ['sideChat'];

_dir = [pequod_var_heli,_pos] call bis_fnc_relativeDirTo;
_wp = group pequod_var_heli addWaypoint[[(_pos select 0)-100*sin(_dir),(_pos select 1)-100*cos(_dir),0],0];
_wp setWaypointType "MOVE";
_wp setWaypointTimeout [5,5,5];
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, dropping smoke.'] remoteExec ['sideChat'];"];

_wp2 = group pequod_var_heli addWaypoint [[(_pos select 0)+100*sin(_dir),(_pos select 1)+100*cos(_dir),0],1];
_wp2 setWaypointType "MOVE";
call compile format ["_wp2 setWaypointStatements [""true"",""[%1] call pequod_fnc_smokescreen""]",_pos];


_wp3 = group pequod_var_heli addWaypoint [[(_pos select 0)+100*sin(_dir),(_pos select 1)+100*cos(_dir),0],1];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointTimeout [5,5,5];
_wp3 setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, smokescreen deployed.'] remoteExec ['sideChat'];"];

_wp4 = group pequod_var_heli addWaypoint [_pos, 1];
_wp4 setWaypointType "LOITER";
_wp4 setWaypointLoiterRadius 500;
pequod_var_heli flyinHeight 100;

group pequod_var_heli setCurrentWaypoint _wp;
true
