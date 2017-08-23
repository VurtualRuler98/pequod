_veh = _this select 0;
_mark = createMarker [format ["tpbox_%1",_veh call BIS_fnc_netId], _veh];
_mark setMarkerType "mil_box";
_mark setMarkerSize [0.5,0.5];
_mark setMarkerText (_this select 1);
_mark setMarkerColor "ColorWEST";
_mark setmarkerpos getpos _veh;
_veh addAction ["Box Travel", {(_this select 1) execVM "sbflag\boxtravel\travel.sqf"}];

