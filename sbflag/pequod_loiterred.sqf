104 cutText ['Click the map to set a loiter position for Pequod','PLAIN DOWN',1];
openMap[true,false];
['fultonDrop','onMapSingleClick',{ [_pos] remoteExecCall ['peq_func_setloiterred', pequod];openMap[false,false];},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};

