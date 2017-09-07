pequod_var_smoke="";
pequod_var_heli = createVehicle [pequod_var_class,pequod_var_spawnpos,[],0,"FLY"];

publicVariable "pequod_var_heli";
createVehicleCrew pequod_var_heli;

pequod_var_heli setPosASL [pequod_var_spawnpos select 0, pequod_var_spawnpos select 1, (pequod_var_spawnpos select 2)+100];
if (pequod_var_spawnpoint) then {
	[missionNamespace,pequod_var_heli,"Pequod"] call bis_fnc_addRespawnPosition;
};

pequod_var_heli addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
pequod_var_heli addEventHandler ["Killed",{[] spawn pequod_fnc_respawn}];
[pequod_var_heli] remoteExec ["pequod_fnc_addaction",0,"pequod_addaction"];

pequod_var_heli addEventHandler ["GetOut",{if (!(isNull pequod_var_curator) && (getAssignedCuratorUnit pequod_var_curator)==(_this select 2)) then{ [nullObj] remoteExec ["pequod_fnc_acc",2];} }];
pequod_var_heli addEventHandler ["GetOut",{if (pequod_var_heli==_this select 0) then {if ((_this select 1) in pequod_var_crew) then {[] call pequod_fnc_respawn;};};}];
pequod_var_crew = crew pequod_var_heli;
pequod_var_heli lockDriver true;
{	_x allowDamage false;
	if ((assignedVehicleRole _x select 0)=="Turret") then {
		pequod_var_heli lockTurret [(assignedVehicleRole _x select 1),true];
	};
	_x setUnitAbility 100; //useless overkill
} forEach pequod_var_crew;

_wp = group pequod_var_heli addWaypoint [pequod_var_spawnpos, 0];
_wp setWaypointType "LOITER";
_wp setWaypointLoiterRadius 500;
group pequod_var_heli setCurrentWaypoint _wp;

[pequod_var_heli,"This is Pequod, I have arrived at the AO."] remoteExec ['sideChat'];

true;