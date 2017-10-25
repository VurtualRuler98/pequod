params [["_base",objNull,[objNull]],["_spawn",false,[true]],["_loadout",false,[true]]];
if (isNull _base) exitWith {["Base script target must be a valid object"] call bis_fnc_error; false};
_base setVariable ["pequod_base",true,true];
_base addEventHandler ["GetOut",{if (!(isNull pequod_var_curator) && (getAssignedCuratorUnit pequod_var_curator)==(_this select 2)) then{ [nullObj] remoteExec ["pequod_fnc_acc",2];} }];
if (_spawn) then {
	[missionNamespace,_base,"Mother Base"] call bis_fnc_addRespawnPosition;
};
if (_loadout) then {
	_base setVariable ["ace_rearm_isSupplyVehicle", true];
	[_base, -10] call ace_refuel_fnc_makeSource;
	_base setVariable ["ACE_isRepairFacility",true];
	_base setVariable ["ACE_Medical_isMedicalFacility",true];
};
_base addAction ["Arsenal",{["Open",true] spawn bis_fnc_arsenal;}];
_base addAction ["Connect to ACC",{[_this select 1] remoteExec ["pequod_fnc_acc",2];},[],1.5,false,true,"","!(isNull pequod_var_curator) && (isNull getAssignedCuratorUnit pequod_var_curator) && vehicle _this == _target"];
_base addAction ["Disconnect from ACC",{[nil] remoteExec ["pequod_fnc_acc",2];},[],1.5,false,true,"","!(isNull pequod_var_curator) && (getAssignedCuratorUnit pequod_var_curator)==_this"];
true
