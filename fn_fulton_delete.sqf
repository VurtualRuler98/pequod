_ply = param [0,objNull,[objNull]];


_ply setPosASL [getPosASL _ply select 0,getPosASL _ply select 1,(getPosASL _ply select 2)+1];
_ply SetVelocity[0,0,100];

sleep 3;

deleteVehicle _ply;
true