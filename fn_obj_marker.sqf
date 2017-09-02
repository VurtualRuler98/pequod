_marker = param [0,"",[""]];
_ply = param [1,objNull,[objNull]];
if (getMarkerColor _marker == "") exitWith {["Pequod marker-objectives must be a valid marker."] call bis_fnc_error;false};
private "_a";
_a = toArray _marker;
_a resize 7;
if (toString _a != "pequod_" ) exitWith {false};
if !(isNull _ply) then {
	[_ply,format ["Pequod, this is %1, designate LZ by marker: %2",_ply,_txt]] remoteExec ["sideChat"];
};

if (!alive pequod_var_heli) exitWith {false};

_txt = markerText _marker;

[] call pequod_fnc_clearobj;
[pequod_var_heli,"This is Pequod, on route to specified LZ!"] remoteExec ["sideChat"];
_wp = group pequod_var_heli addWaypoint [getmarkerpos _marker, 0];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 10;
pequod_var_heli flyinHeight 100;
_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, on station at LZ!'] remoteExec ['sideChat']; pequod_var_heli land 'GET IN';"];
group pequod_var_heli setCurrentWaypoint _wp;
