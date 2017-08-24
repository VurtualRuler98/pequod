_pos = param [0,[0,0,0],[[]],[2,3]];


if (!alive pequod_var_heli) exitWith {true};

[pequod_var_heli,'This is Pequod, preparing for supply drop at the specified coordinates.'] remoteExec ['sideChat'];

group pequod_var_heli setCombatMode "BLUE";
[group pequod_var_heli,currentWaypoint group pequod_var_heli] setWaypointStatements ["true",""];
{deleteWaypoint _x} forEach waypoints group pequod_var_heli;
pequod_var_heli land "NONE";
_dir = [pequod_var_heli,_pos] call bis_fnc_relativeDirTo;
_wp = group pequod_var_heli addWaypoint[[(_pos select 0)-100*sin(_dir),(_pos select 1)-100*cos(_dir),0],0];
_wp setWaypointType "MOVE";
_wp setWaypointTimeout [5,5,5];
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, dropping supplies.'] remoteExec ['sideChat'];"];

_wp2 = group pequod_var_heli addWaypoint [[(_pos select 0)+100*sin(_dir),(_pos select 1)+100*cos(_dir),0],1];
_wp2 setWaypointType "MOVE";
if (isNull _shell) then {
	_wp2 setWaypointStatements ["true","[] call pequod_fnc_supply"];
} else {
	call compile format ["_wp2 setWaypointStatements [""true"",""[%1] call pequod_fnc_supply""]",_shell];
};


_wp3 = group pequod_var_heli addWaypoint [[(_pos select 0)+100*sin(_dir),(_pos select 1)+100*cos(_dir),0],1];
_wp3 setWaypointType "MOVE";
_wp3 setWaypointTimeout [5,5,5];
_wp3 setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, supplies dropped.'] remoteExec ['sideChat'];"];

_wp4 = group pequod_var_heli addWaypoint [_pos, 1];
_wp4 setWaypointType "LOITER";
_wp4 setWaypointLoiterRadius 500;

pequod_var_heli flyinHeight 100;

group pequod_var_heli setCurrentWaypoint _wp;
true
