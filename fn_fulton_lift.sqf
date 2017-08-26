_ply = param [0,objNull,[objNull]];
sleep 1;
if (!alive _ply || isNull _ply || not (_ply isKindOf "Man")) exitWith {false};

_ply switchMove "Para_Pilot";
_ply setPosASL [getPosASL _ply select 0,getPosASL _ply select 1,(getPosASL _ply select 2)+1];
_ply SetVelocity[0,0,100];

sleep 1;

if (alive _ply) then {
	_ply SetVelocity[0,0,0];
	_ply moveincargo pequod_var_heli;
};
[pequod_var_heli,"This is Pequod, fulton recovery subject on board helicopter."] remoteExec ['sideChat'];