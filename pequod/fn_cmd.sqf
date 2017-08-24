_cmd = param [0,"",[""]];

MENU_PEQUOD_CMD = [
	["Pequod",true],
	["Contact Pequod",[2],"",-5,[["expression","['marker'] call pequod_fnc_cmd"]],"1","1"],
	["Contact Pequod (LZ by Smoke)",[3],"",-5,[["expression","['lzsmoke'] call pequod_fnc_cmd"]],"1","1"],
	["Contact Pequod (Loiter)",[4],"",-5,[["expression","['loiter'] call pequod_fnc_cmd"]],"1","1"],
	["Contact Pequod (Fire Support)",[5],"",-5,[["expression","['hot'] call pequod_fnc_cmd"]],"1","1"],
	["Contact Pequod (Recover Fulton)",[6],"",-5,[["expression","['fulton'] call pequod_fnc_cmd"]],"1","1"],
	["Contact Pequod (Supply Drop)",[7],"",-5,[["expression","['arsenal'] call pequod_fnc_cmd"]],"1","1"],
	["Contact Pequod (Smokescreen)",[8],"",-5,[["expression","['smokescreen'] call pequod_fnc_cmd"]],"1","1"],
	["Contact Pequod (Set ROE)",[9],"",-5,[["expression","['roe'] call pequod_fnc_cmd"]],"1","1"]
];

MENU_PEQUOD_SMOKE_LAND = [
	["Designate LZ by...",true],
	["Red smoke",[2],"",-5,[["expression","['smokeShellRed',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Green smoke",[3],"",-5,[["expression","['smokeShellGreen',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Yellow smoke",[4],"",-5,[["expression","['smokeShellYellow',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Purple smoke",[5],"",-5,[["expression","['smokeShellPurple',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Blue smoke",[6],"",-5,[["expression","['smokeShellBlue',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Orange smoke",[7],"",-5,[["expression","['smokeShellOrange',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"]
];

MENU_PEQUOD_ROE = [
	["Pequod",true],
	["Hold Fire",[2],"",-5,[["expression","['BLUE'] remoteExecCall ['pequod_fnc_roe',pequod_var_heli];"]],"1","1"],
	["Fire at will",[3],"",-5,[["expression","['YELLOW'] remoteExecCall ['pequod_fnc_roe',pequod_var_heli];"]],"1","1"]

];

if (_cmd=="menu") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_CMD";
	};
};

if (_cmd=="marker") then {
	104 cutText ['Click the map to set a waypoint for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	{ private "_a"; _a = toArray _x; _a resize 7; if (toString _a == "pequod_" ) then { _x setMarkerAlphaLocal 1; } } forEach allMapMarkers; 
	['fultonDrop','onMapSingleClick',{
		[_pos,_this select 4] spawn {
		_mouseover = (ctrlMapMouseOver (findDisplay 12 displayCtrl 51));
		if (_mouseover select 0 == 'marker') then { 
			private '_a'; _a = toArray (_mouseover select 1); _a resize 7; if (toString _a == 'pequod_' ) then { [_mouseover select 1] remoteExecCall ['pequod_fnc_obj_marker', pequod_var_heli];openMap[false,false];};
		};
		};
		},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
		{ private "_a"; _a = toArray _x; _a resize 7; if (toString _a == "pequod_" ) then { _x setMarkerAlphaLocal 0; } } forEach allMapMarkers; 
	};
};


if (_cmd=="lzsmoke") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_SMOKE_LAND";
	};
};


if (_cmd=="loiter") then {
	104 cutText ['Click the map to set a loiter position for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos] remoteExecCall ['pequod_fnc_obj_loiter', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};


if (_cmd=="hot") then {
	104 cutText ['Click the map to set an engagement area for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos] remoteExecCall ['pequod_fnc_obj_hot', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};


if (_cmd=="fulton") then {
	[] remoteExecCall ['pequod_fnc_obj_fulton', pequod_var_heli]
};


if (_cmd=="arsenal") then {
	104 cutText ['Click the map to request a supply drop from Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos] remoteExecCall ['pequod_fnc_obj_supply', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};


if (_cmd=="smokescreen") then {
	104 cutText ['Click the map to call in a smokescreen from Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos] remoteExecCall ['pequod_fnc_obj_smokescreen', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};

if (_cmd=="roe") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_ROE";
	};
};