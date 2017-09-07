params [["_pequod",objNull,[objNull]]];
if (isNull _veh || not (_veh isKindOf "Helicopter")) exitWith {["Pequod must be a valid helicopter"] call bis_fnc_error; false};
_pequod addAction ["Arsenal",{["Open",true] spawn bis_fnc_arsenal;}];
_pequod addAction ["Connect to ACC",{[_this select 1] remoteExec ["pequod_fnc_acc",2];},[],1.5,false,true,"","!(isNull pequod_var_curator) && (isNull getAssignedCuratorUnit pequod_var_curator) && vehicle _this == _target"];
_pequod addAction ["Disconnect from ACC",{[nil] remoteExec ["pequod_fnc_acc",2];},[],1.5,false,true,"","!(isNull pequod_var_curator) && (getAssignedCuratorUnit pequod_var_curator)==_this"];