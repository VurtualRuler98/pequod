_smoke = param [0,"smokeShell",[""]];
_ply = param [1,objNull,[objNull]];
_smokeName = getText (configFile >> "cfgMagazines" >> _smoke >> "displayNameShort");
if !(isNull _ply) then {
	[_ply,format ["Pequod, this is %1, designate objective by %2",_ply,_smokeName]] remoteExec ["sideChat"];
};

if (!alive pequod_var_heli) exitWith {true};
if (pequod_var_smoke=="") exitWith {[pequod_var_heli,"This is Pequod, my task does not require smoke marking."] remoteExec ['sideChat'];false};
_shell = pequod_var_heli nearObjects[_smoke,1000] select 0;

if (isNil '_shell') exitWith { [pequod_var_heli,"This is Pequod, I can't see the smoke you've specified."] remoteExec ['sideChat'];false};


if (pequod_var_smoke=="LZ") then {
	[] call pequod_fnc_clearobj;
	[pequod_var_heli,'This is Pequod, on route to specified LZ.'] remoteExec ['sideChat'];
	_wp = group pequod_var_heli addWaypoint [getPos _shell, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;
	pequod_var_heli flyinHeight 100;
	_lz = "Land_HelipadEmpty_F" createVehicle (getPos _shell);
		_lz setPosASL [getPosASL _shell select 0, getPosASL _shell select 1, (getPosASL _shell select 2)];
	_wp setWaypointStatements ["true","[pequod_var_heli,'This is Pequod, on station at LZ!'] remoteExec ['sideChat']; pequod_var_heli land 'GET OUT';"];
	group pequod_var_heli setCurrentWaypoint _wp;
	pequod_var_current_lz=_lz;
	[_lz] spawn {
		_lz=_this select 0;
		waitUntil {_lz distance pequod_var_heli<4 || isNil "pequod_var_current_lz" || pequod_var_current_lz!=_lz};
		waitUntil {_lz distance pequod_var_heli>10 || isNil "pequod_var_current_lz" || pequod_var_current_lz!=_lz};
		sleep 4;
		deleteVehicle _lz;
	};
	pequod_var_smoke="";
};

true