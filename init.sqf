peq_func_init = {
	[] spawn {
		pequodSpawnPos = [getPosASL pequod select 0,getPosASL pequod select 1,(getPosASL pequod select 2)+100];
		deleteVehicle pequod;
		[] call peq_func_spawn;
	};
	[] spawn {
		while {true} do {
			sleep 60;
			if (alive pequod) then {
				pequod setFuel 1;
			};
		};
	};
};
peq_func_spawn = {
	pequod = createVehicle ["CUP_B_Mi24_D_CDF",pequodSpawnPos,[],0,"FLY"];
	publicVariable "pequod";
	createVehicleCrew pequod;
	pequod setPosASL pequodSpawnPos;
	pequod addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
	pequod addEventHandler ["Killed",{[] spawn peq_func_respawn}];
	(driver pequod) allowDamage false;
	pequod lockDriver true;
	(gunner pequod) allowDamage false;
	pequod lockTurret [[0],true];
	[pequod,"This is Pequod, I have arrived at the AO."] remoteExec ['sideChat'];
	_wp = group pequod addWaypoint [pequodSpawnPos, 0];
	_wp setWaypointType "LOITER";
	_wp setWaypointLoiterRadius 500;
	group pequod setCurrentWaypoint _wp;
	pequod addAction ["Arsenal",{["Open",true] spawn bis_fnc_arsenal;}];
};
peq_func_respawn = {
	_driver = driver pequod;
	_gunner = gunner pequod;
	[pequod,"THIS IS PEQUOD, I'M GOING DOWN!"] remoteExec ['sideChat'];
	sleep 10;
	deleteVehicle _driver;
	deleteVehicle _gunner;
	[] call peq_func_spawn;
};



MENU_PEQUOD_SMOKE_LAND = [
	["Designate LZ by...",true],
	["Any smoke",[2],"",-5,[["expression","['smokeShell',player] remoteExecCall ['peq_func_customobj',pequod];"]],"1","1"],
	["Red smoke",[3],"",-5,[["expression","['smokeShellRed',player] remoteExecCall ['peq_func_customobj',pequod];"]],"1","1"]
];

peq_func_customobj = {
	if (!alive pequod) exitWith {};
	_smoke = _this select 0;
	_shell = pequod nearObjects[_smoke,500] select 0;
	if (isnil '_shell') then {
		[pequod,"This is Pequod, I can't see the smoke you've specified."] remoteExec ['sideChat'];
	} else {
		group pequod setCombatMode "BLUE";
		[pequod,'This is Pequod, on route to specified LZ.'] remoteExec ['sideChat'];
		[group pequod,currentWaypoint group pequod] setWaypointStatements ["true",""];
		{deleteWaypoint _x} forEach waypoints group pequod;
		pequod land "NONE";
		_wp = group pequod addWaypoint [getPos _shell, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 10;
		pequod flyinHeight 100;
		_wp setWaypointStatements ["true","[pequod,'This is Pequod, on station at LZ!'] remoteExec ['sideChat']; pequod land 'GET IN';"];
		group pequod setCurrentWaypoint _wp;
	};
};
peq_func_getfulton = {
	if (!alive pequod) exitWith {};
	if (pequod emptyPositions "cargo" == 0) exitWith {
		[pequod,"This is Pequod, passenger space is full, can't recover fulton."] remoteExec ['sideChat'];
	};
	_chutes = nearestObjects [pequod,["B_Parachute_02_F"],2000];
	_chute = {if (_x getVariable "fulton_ischute") exitWith {_x}} forEach _chutes;
	if (isnil '_chute') then {
		[pequod,"This is Pequod, I can't see any fulton balloons."] remoteExec ['sideChat'];
	} else {
		group pequod setCombatMode "BLUE";
		[pequod,'This is Pequod, recovering fulton!'] remoteExec ['sideChat'];
		[group pequod,currentWaypoint group pequod] setWaypointStatements ["true",""];
		{deleteWaypoint _x} forEach waypoints group pequod;
		pequod land "NONE";
		_wp = group pequod addWaypoint [getPos _chute, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 10;
		pequod flyinHeight 100;
		group pequod setCurrentWaypoint _wp;
	};
};
peq_func_setloiter = {
	if (!alive pequod) exitWith {};
	_pos = _this select 0;
	group pequod setCombatMode "BLUE";
	[pequod,'This is Pequod, heading to specified coordinates.'] remoteExec ['sideChat'];
	[group pequod,currentWaypoint group pequod] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod;
	pequod land "NONE";
	_wp = group pequod addWaypoint [_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 10;
	pequod flyinHeight 100;
	_wp setWaypointStatements ["true","[pequod,'This is Pequod, I have arrived at marker!'] remoteExec ['sideChat'];"];
	_wp2 = group pequod addWaypoint [_pos, 1];
	_wp2 setWaypointType "LOITER";
	_wp2 setWaypointLoiterRadius 500;
	group pequod setCurrentWaypoint _wp;
};
peq_func_setloiterred = {
	if (!alive pequod) exitWith {};
	_pos = _this select 0;
	group pequod setCombatMode "RED";
	[pequod,"This is Pequod, I'm coming in hot, find cover!"] remoteExec ['sideChat'];
	[group pequod,currentWaypoint group pequod] setWaypointStatements ["true",""];
	{deleteWaypoint _x} forEach waypoints group pequod;
	pequod land "NONE";
	_wp = group pequod addWaypoint [_pos, 0];
	_wp setWaypointType "HOLD";
	pequod flyinHeight 100;
	group pequod setCurrentWaypoint _wp;
};
peq_func_setobj = {
	if (!alive pequod) exitWith {};
	_marker = _this select 0;
	_txt = markerText _marker;
	if (_txt=="Helicopter LZ") then {
		group pequod setCombatMode "BLUE";
		[pequod,"This is Pequod, on route to specified LZ!"] remoteExec ["sideChat"];
		[group pequod,currentWaypoint group pequod] setWaypointStatements ["true",""];
		{deleteWaypoint _x} forEach waypoints group pequod;
		pequod land "NONE";
		_wp = group pequod addWaypoint [getmarkerpos _marker, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 10;
		pequod flyinHeight 100;
		_wp setWaypointStatements ["true","[pequod,'This is Pequod, on station at LZ!'] remoteExec ['sideChat']; pequod land 'GET IN';"];
		group pequod setCurrentWaypoint _wp;
	};
	if (_txt=="Helicopter Hover") then {
		group pequod setCombatMode "BLUE";
		[pequod,'This is Pequod, on route to specified position!'] remoteExec ['sideChat'];
		[group pequod,currentWaypoint group pequod] setWaypointStatements ["true",""];
		{deleteWaypoint _x} forEach waypoints group pequod;
		pequod land "NONE";
		_wp = group pequod addWaypoint [getmarkerpos _marker, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 0;
		pequod flyinHeight 100;
		_wp setWaypointStatements ["true","[pequod,'This is Pequod, on station and holding position!'] remoteExec ['sideChat'];pequod flyinHeight 6;"];
		group pequod setCurrentWaypoint _wp;
	};
	if (_txt=="Helicopter RTB") then {
		group pequod setCombatMode "BLUE";
		[pequod,'This is Pequod, returning to base!'] remoteExec ['sideChat'];
		[group pequod,currentWaypoint group pequod] setWaypointStatements ["true",""];
		{deleteWaypoint _x} forEach waypoints group pequod;
		pequod land "NONE";
		_wp = group pequod addWaypoint [getmarkerpos _marker, 0];
		_wp setWaypointType "MOVE";
		pequod flyinHeight 100;
		_wp setWaypointStatements ["true","pequod land 'LAND'; pequod setDamage 0;"];
		group pequod setCurrentWaypoint _wp;
	};
};

fulton_func_launch = {
	_ply = _this select 0;
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

		if (_chute distance2D pequod<100 and (getPosATL pequod select 2)>50) then {
			deleteVehicle _chute;
			if (pequod emptyPositions "cargo" > 0) then {
			[_ply] spawn fulton_func_lift; 
			} else {
				[pequod,"This is Pequod, passenger space is full, can't recover fulton."] remoteExec ['sideChat'];
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
};
fulton_func_init = {
	_this select 0 setVariable ["fulton_deployed",nil,true];
	[_this select 0,
	"Launch Fulton Balloon",
	"",
	"",
	"(_target == _this) && isNil {_target getVariable 'fulton_deployed'} && (animationState _target in ['amovpsitmstpsnonwpstdnon_ground','amovpsitmstpslowwrfldnon','amovpsitmstpsnonwnondnon_ground'])",
	"animationState _target in ['amovpsitmstpsnonwpstdnon_ground','amovpsitmstpslowwrfldnon','amovpsitmstpsnonwnondnon_ground'] && isNil {_target getVariable 'fulton_deployed'}",
	{},
	{},
	{[_this select 0] spawn fulton_func_launch},
	{},
	[],
	3,
	0,
	false,
	false ] call bis_fnc_holdActionAdd;
	[_this select 0,
	"Attach fulton to target",
	"",
	"",
	"(_this == _target) && (cursorTarget distance _target<2) && (cursorTarget getVariable 'ace_captives_isHandcuffed') && isNil {cursorTarget getVariable 'fulton_deployed'}",
	"(cursorTarget distance _target<2) && (cursorTarget getVariable 'ace_captives_isHandcuffed')  && isNil {cursorTarget getVariable 'fulton_deployed'}",
	{},
	{},
	{[cursorTarget] remoteExec ["fulton_func_launch",cursorTarget]},
	{},
	[],
	3,
	0,
	false,
	false ] call bis_fnc_holdActionAdd;
};
fulton_func_lift = {
	_ply = _this select 0;
	_ply switchmove "Para_Pilot";
	_ply setPosASL [getPosASL _ply select 0,getPosASL _ply select 1,(getPosASL _ply select 2)+1];
	_ply SetVelocity[0,0,100];
	sleep 3;
	if (alive _ply) then {
		_ply SetVelocity[0,0,0];
		_ply moveincargo pequod;
	};
	[pequod,"This is Pequod, fulton recovery subject on board helicopter."] remoteExec ['sideChat'];
};
[gman] spawn fulton_func_init;