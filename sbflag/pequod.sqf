104 cutText ['Click the map to set a waypoint for Pequod','PLAIN DOWN',1];
openMap[true,false];
['fultonDrop','onMapSingleClick',{
	[_pos,_this select 4] spawn {
	_mouseover = (ctrlMapMouseOver (findDisplay 12 displayCtrl 51));
	if (_mouseover select 0 == 'marker') then { 
		private '_a'; _a = toArray (_mouseover select 1); _a resize 7; if (toString _a == 'pequod_' ) then { [_mouseover select 1] remoteExecCall ['peq_func_setobj', pequod];openMap[false,false];};
	};
	};
	},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};

