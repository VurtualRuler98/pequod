_mode = param [0,"BLUE",[""]];

if (_mode=="BLUE" || _mode=="YELLOW") then {
	pequod_var_roe = _mode;
};
if ((combatMode group pequod_var_heli)!="RED") then {
	group pequod_var_heli setCombatMode pequod_var_roe;
};
if (_mode=="BLUE") then {
	[pequod_var_heli,"This is Pequod, will hold fire outside of attack runs."] remoteExec ['sideChat'];
} else {
	[pequod_var_heli,"This is Pequod, firing at will outside of attack runs."] remoteExec ['sideChat'];
};
true
