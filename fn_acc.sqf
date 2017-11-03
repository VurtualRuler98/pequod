_ply = param [0,objNull,[objNull]];
if (!isNull _ply && !(_ply isKindOf "Man")) exitWith {["ACC Boss must be a human."] call bis_fnc_error; false};
if (isNull _ply) then {
	unassignCurator pequod_var_curator;
} else {
	if (vehicle _ply == pequod_var_heli || vehicle _ply getVariable ["pequod_base",false] || (_ply call pequod_fnc_canremote)) then {
		_ply assignCurator pequod_var_curator;
	}
};
true