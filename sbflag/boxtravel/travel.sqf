104 cutText ['Click the map to travel.','PLAIN DOWN',1];
openMap[true,false];
['fultonDrop','onMapSingleClick',{
	[_pos,_this select 4] spawn {
	_mouseover = (ctrlMapMouseOver (findDisplay 12 displayCtrl 51));
	if (_mouseover select 0 == 'marker') then { 
		private '_a'; _a = toArray (_mouseover select 1); _a resize 6; if (toString _a == 'tpbox_' ) then {private '_b'; _b = toArray (_mouseover select 1); _b deleteRange[0,6]; _obj = (toString _b) call bis_fnc_objectFromNetId; [_this select 1,getPosASL _obj] remoteExecCall ['setPosASL', 0];openMap[false,false];};
	};
	};
	},[_this]] call BIS_fnc_addStackedEventHandler;
	[] spawn {
		waitUntil {!visibleMap};
		['fultonDrop','onMapSingleClick'] call BIS_fnc_removeStackedEventHandler;
		104 cutText ['','PLAIN DOWN',5];
	};

