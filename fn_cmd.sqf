_cmd = param [0,"",[""]];
showCommandingMenu "";
MENU_PEQUOD_CMD = [
	["Pequod, ...",true],
	["Designate LZ by...",[2],"",-5,[["expression","['menu_land'] call pequod_fnc_cmd"]],"1","1"],
	//["Special air insertion...",[2],"",-5,[["expression","['menu_land'] call pequod_fnc_cmd"]],"1","1"],
	["Move to position and...",[3],"",-5,[["expression","['menu_move'] call pequod_fnc_cmd"]],"1","1"],
	["CAS requested...",[4],"",-5,[["expression","['menu_air'] call pequod_fnc_cmd"]],"1","1"],
	["Air drop request at grid...",[5],"",-5,[["expression","['arsenal'] call pequod_fnc_cmd"]],"1","1"],
	["Recover fulton near...",[6],"",-5,[["expression","['menu_fulton'] call pequod_fnc_cmd"]],"1","1"],
	["Change in SOP...",[7],"",-5,[["expression","['roe'] call pequod_fnc_cmd"]],"1","1"],
	["Designate objective by...",[8],"",-5,[["expression","['smoke'] call pequod_fnc_cmd"]],"1","1"],
	["RTB immediately.",[9],"",-5,[["expression","['rtb'] call pequod_fnc_cmd"]],"1","1"]
];

MENU_PEQUOD_LAND = [
	["Pequod, Designate LZ by...",true],
	["Marker...",[2],"",-5,[["expression","['marker'] call pequod_fnc_cmd"]],"1","1"],
	["Smoke grenade near grid...",[3],"",-5,[["expression","['lzsmoke'] call pequod_fnc_cmd"]],"1","1"],
	["Coordinates at grid...",[4],"",-5,[["expression","['lzgrid'] call pequod_fnc_cmd"]],"1","1"]
];
MENU_PEQUOD_MOVE = [
	["Pequod, Move to position and...",true],
	["Loiter near grid...",[2],"",-5,[["expression","['loiter'] call pequod_fnc_cmd"]],"1","1"],
	["Low hover near grid...",[3],"",-5,[["expression","['hover'] call pequod_fnc_cmd"]],"1","1"],
	["Prepare for helicopter jumping near grid...",[4],"",-5,[["expression","['jump'] call pequod_fnc_cmd"]],"1","1"]
];
MENU_PEQUOD_FULTON = [
	["Pequod, recover fulton near...",true],
	["Coordinates at grid...",[2],"",-5,[["expression","['fulton_grid'] call pequod_fnc_cmd"]],"1","1"],
	["Your current location.",[3],"",-5,[["expression","['fulton_now'] call pequod_fnc_cmd"]],"1","1"]
];
MENU_PEQUOD_AIR = [
	["Pequod, CAS requested...",true],
	["Fire support at grid... ",[2],"",-5,[["expression","['hot'] call pequod_fnc_cmd"]],"1","1"],
	["Smokescreen at grid...",[3],"",-5,[["expression","['smokescreen'] call pequod_fnc_cmd"]],"1","1"]

];
	

MENU_PEQUOD_SMOKE = [
	["Pequod, designate objective by...",true],
	["Red smoke",[2],"",-5,[["expression","['smokeShellRed',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Green smoke",[3],"",-5,[["expression","['smokeShellGreen',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Yellow smoke",[4],"",-5,[["expression","['smokeShellYellow',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Purple smoke",[5],"",-5,[["expression","['smokeShellPurple',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Blue smoke",[6],"",-5,[["expression","['smokeShellBlue',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"],
	["Orange smoke",[7],"",-5,[["expression","['smokeShellOrange',player] remoteExecCall ['pequod_fnc_obj_smoke',pequod_var_heli];"]],"1","1"]
];

MENU_PEQUOD_ROE = [
	["Pequod, change in SOP, ...",true],
	["Support ROE: Hold Fire.",[2],"",-5,[["expression","['BLUE'] remoteExecCall ['pequod_fnc_roe',pequod_var_heli];"]],"1","1"],
	["Support ROE: Fire at Will.",[3],"",-5,[["expression","['YELLOW'] remoteExecCall ['pequod_fnc_roe',pequod_var_heli];"]],"1","1"]

];

if (_cmd=="menu") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_CMD";
	};
};
if (_cmd=="menu_land") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_LAND";
	};
};
if (_cmd=="menu_move") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_MOVE";
	};
};
if (_cmd=="menu_air") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_AIR";
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
			private '_a'; _a = toArray (_mouseover select 1); _a resize 7; if (toString _a == 'pequod_' ) then { [_mouseover select 1,player] remoteExecCall ['pequod_fnc_obj_marker', pequod_var_heli];openMap[false,false];};
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
	104 cutText ['Click the map to define the smoke area.','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos] remoteExecCall ['pequod_fnc_obj_lzsmoke', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};
if (_cmd=="lzgrid") then {
	104 cutText ['Click the map to set an LZ search area for Pequod.','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_lzgrid', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};

if (_cmd=="loiter") then {
	104 cutText ['Click the map to set a loiter position for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_loiter', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};
if (_cmd=="hover") then {
	104 cutText ['Click the map to set a low hover position for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_hover', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};
if (_cmd=="jump") then {
	104 cutText ['Click the map to set a helicopter jumping area for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_jump', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};


if (_cmd=="hot") then {
	104 cutText ['Click the map to set an engagement area for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_hot', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};


if (_cmd=="menu_fulton") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_FULTON";
	};
};
if (_cmd=="fulton_grid") then {
	104 cutText ['Click the map to set a fulton search position for Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_fulton_grid', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};
if (_cmd=="fulton_now") then {
	[player] remoteExecCall ['pequod_fnc_obj_fulton', pequod_var_heli]
};


if (_cmd=="arsenal") then {
	104 cutText ['Click the map to request a supply drop from Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_supply', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};
};


if (_cmd=="smokescreen") then {
	104 cutText ['Click the map to call in a smokescreen from Pequod','PLAIN DOWN',1];
	openMap[true,false];
	['fultonDrop','onMapSingleClick',{ [_pos,player] remoteExecCall ['pequod_fnc_obj_smokescreen', pequod_var_heli];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
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
if (_cmd=="smoke") then {
	[] spawn {
	showCommandingMenu "#USER:MENU_PEQUOD_SMOKE";
	};
};


if (_cmd=="rtb") then {
	[player] remoteExecCall ['pequod_fnc_obj_rtb', pequod_var_heli]
};