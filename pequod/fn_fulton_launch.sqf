_ply = param [0,objNull,[objNull]];

if (isNull _ply || not (_ply isKindOf "Man")) exitWith {["Only valid humans can be fultoned."] call bis_fnc_error; false};

_ply setVariable ["fulton_deployed",true,true];

_chute = "b_parachute_02_F" createVehicle position _ply;
_chute setPosASL [getposASL _ply select 0,getposASL _ply select 1,(getposASL _ply select 2)+10];
_chute setVelocity [0,0,300];
sleep 2;
_chute attachTo [_ply];
_chute setVariable["fulton_ischute",true,true];

_wait = true;
_pos = getPosASL _ply;
while {_wait} do {


	if (_chute distance2D pequod_var_heli<100 and (getPosATL pequod_var_heli select 2)>50) then {
		deleteVehicle _chute;
		if (pequod_var_heli emptyPositions "cargo" > 0) then {
		[_ply] spawn pequod_fnc_fulton_lift; 
		} else {
			[pequod_var_heli,"This is Pequod, passenger space is full, can't recover fulton."] remoteExec ['sideChat'];
		};
		_wait = false;
	};
	if (_pos distance getPosASL _ply>1) then {
		_wait = false;
		detach _chute;
		sleep 1;
		_chute setVelocity [0,0,300];
		sleep 4;
		deleteVehicle _chute;
	};
	if (!alive _chute) then {
		_wait = false;
	};
	sleep 1;
};
_ply setVariable ["fulton_deployed",nil,true];