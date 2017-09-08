params [["_cargo",objNull,[objNull]]];
if (isNull _cargo ) exitWith {false};
[_cargo,
"Dispose of supplies",
"",
"",
"isNull attachedTo _target",
"true",
{},
{},
{[_this select 0] remoteExec ["pequod_fnc_fulton_delete",_this select 0]},
{},
[],
3,
0,
false,
false ] call bis_fnc_holdActionAdd;
_cargo addAction ["Arsenal",{["Open",true] spawn bis_fnc_arsenal;}];