
pequod_var_heli = createVehicle [pequod_var_class,pequod_var_spawnpos,[],0,"FLY"];
publicVariable "pequod_var_heli";
createVehicleCrew pequod_var_heli;

pequod_var_heli setPosASL pequod_var_spawnpos;

pequod_var_heli addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
pequod_var_heli addEventHandler ["Killed",{[] spawn pequod_fnc_respawn}];
pequod_var_heli addAction ["Arsenal",{["Open",true] spawn bis_fnc_arsenal;}];
pequod_var_heli addAction ["Connect to ACC",{[_this select 1] remoteExec ["pequod_fnc_acc",2];},[],1.5,false,true,"","!(isNull pequod_var_curator) && (isNull getAssignedCuratorUnit pequod_var_curator) && vehicle _this == _target"];
pequod_var_heli addAction ["Disconnect from ACC",{[nil] remoteExec ["pequod_fnc_acc",2];},[],1.5,false,true,"","!(isNull pequod_var_curator) && (getAssignedCuratorUnit pequod_var_curator)==_this"];
pequod_var_heli addEventHandler ["GetOut",{if (!(isNull pequod_var_curator) && (getAssignedCuratorUnit pequod_var_curator)==(_this select 2)) then{ [nullObj] remoteExec ["pequod_fnc_acc",2];} }];
pequod_var_heli addEventHandler ["GetOut",{if (pequod_var_heli==_this select 0) then {if ((_this select 1) in pequod_var_crew) then {[] call pequod_fnc_respawn;};};}];
pequod_var_crew = crew pequod_var_heli;
pequod_var_heli lockDriver true;
{	_x allowDamage false;
	if ((assignedVehicleRole _x select 0)=="Turret") then {
		pequod_var_heli lockTurret [(assignedVehicleRole _x select 1),true];
	}
} forEach pequod_var_crew;

_wp = group pequod_var_heli addWaypoint [pequod_var_spawnpos, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterRadius 500;
group pequod_var_heli setCurrentWaypoint _wp;

[pequod_var_heli,"This is Pequod, I have arrived at the AO."] remoteExec ['sideChat'];

true;