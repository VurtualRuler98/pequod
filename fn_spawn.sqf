pequod_var_smoke="";
pequod_var_heli = createVehicle [pequod_var_class,pequod_var_spawnpos,[],0,"FLY"];

publicVariable "pequod_var_heli";
createVehicleCrew pequod_var_heli;

pequod_var_heli setPosASL [pequod_var_spawnpos select 0, pequod_var_spawnpos select 1, (pequod_var_spawnpos select 2)+100];
if (pequod_var_spawnpoint) then {
	[missionNamespace,pequod_var_heli,"Pequod"] call bis_fnc_addRespawnPosition;
};
if (pequod_var_canloadout) then {
	pequod_var_heli setVariable ["ace_rearm_isSupplyVehicle", true];
	[pequod_var_heli, -10] call ace_refuel_fnc_makeSource;
	pequod_var_heli setVariable ["ACE_isRepairFacility",true];
	pequod_var_heli setVariable ["ACE_Medical_isMedicalFacility",true];
};
pequod_var_heli addEventHandler ["Fired",{(_this select 0) setVehicleAmmo 1}];
pequod_var_heli addEventHandler ["Killed",{[] spawn pequod_fnc_respawn}];
[pequod_var_heli] remoteExec ["pequod_fnc_addaction",0,"pequod_addaction"];

pequod_var_heli addEventHandler ["GetOut",{if (!(isNull pequod_var_curator) && (getAssignedCuratorUnit pequod_var_curator)==(_this select 2) && !([_this select 2] call pequod_fnc_canremote)) then{ [nullObj] remoteExec ["pequod_fnc_acc",2];} }];
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
driver pequod_var_heli setVariable ["VCOM_NOPATHING_Unit",1,false];
[pequod_var_heli,"This is Pequod, I have arrived at the AO."] remoteExec ['sideChat'];

true;