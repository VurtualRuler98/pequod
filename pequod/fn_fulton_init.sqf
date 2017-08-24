_ply = param [0,objNull,[objNull]];

if (isNull _veh || not (_veh isKindOf "Man")) exitWith {["Only valid humans can use fultons."] call bis_fnc_error; false};

[_ply,
"Launch Fulton Balloon",
"",
"",
"(_target == _this) && isNil {_target getVariable 'fulton_deployed'} && (animationState _target in ['amovpsitmstpsnonwpstdnon_ground','amovpsitmstpslowwrfldnon','amovpsitmstpsnonwnondnon_ground'])",
"animationState _target in ['amovpsitmstpsnonwpstdnon_ground','amovpsitmstpslowwrfldnon','amovpsitmstpsnonwnondnon_ground'] && isNil {_target getVariable 'fulton_deployed'}",
{},
{},
{[_this select 0] spawn pequod_fnc_fulton_launch},
{},
[],
3,
0,
false,
false ] call bis_fnc_holdActionAdd;


[_ply,
"Attach fulton to target",
"",
"",
"(_this == _target) && (cursorTarget distance _target<2) && (cursorTarget getVariable 'ace_captives_isHandcuffed') && isNil {cursorTarget getVariable 'fulton_deployed'}",
"(cursorTarget distance _target<2) && (cursorTarget getVariable 'ace_captives_isHandcuffed')  && isNil {cursorTarget getVariable 'fulton_deployed'}",
{},
{},
{[cursorTarget] remoteExec ["pequod_fnc_fulton_launch",cursorTarget]},
{},
[],
3,
0,
false,
false ] call bis_fnc_holdActionAdd;