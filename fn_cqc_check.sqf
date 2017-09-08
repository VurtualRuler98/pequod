params [["_ply",objNull,[objNull]],["_tgt",objNull,[objNull]]];
private ["_cangrab"];
if (_ply != _tgt) exitWith {false};
if (count nearestObjects [_ply,['Man'],5] > 1) then {
	_grab = nearestObjects [_ply,['Man'],5] select 1;
	_grabber = attachedTo _grab;
	if (isNil "_grabber") then {_grabber = objNull};
	_cangrab = true;
	if (_cangrab) then { _cangrab = [position  _ply, (getDir _ply),90,position _grab] call BIS_fnc_inAngleSector;};
	if (_cangrab) then { _cangrab = !([position _grab, (getDir _grab),30,position _ply] call BIS_fnc_inAngleSector);};
	if (_cangrab && (_grab distance _ply<2) && (alive _grab) && (isNull _grabber) && !(_grab getVariable 'ACE_isUnconscious') && ((isNull (_ply getVariable 'cqc_choke_tgt')) || ((_ply getVariable 'cqc_choke_tgt')==_grab))) then {_cangrab = true;} else {_cangrab = false;};
};
_cangrab;