# pequod
Simple Metal Gear style "Pequod" helicopter scripts for Arma 3.

To use this, you need to clone or download the scripts into a directory in your Arma mission.
Ideally, name this directory "pequod", the path like so: "missionname.terrain/pequod/fn_init.sqf"

Include the header file in your cfgFunctions in description.ext:

	#include "pequod\pequod_fnc.hpp"

or if you don't have one, stick this whole chunk in it:

  class cfgFunctions {
	  #include "pequod\pequod_fnc.hpp"
  };

Then create a suitable helicopter in the editor(ideally, empty, as it will be deleted upon mission start) and put this in the init:

  [this] call pequod_fnc_init;

The total available parameters are as follows:

[vehicle,landed,respawn,curator] call pequod_fnc_init;

vehicle: default null (required)
The vehicle object to use as a base for pequod's helicopter. It must be a helicopter.
The vehicle specified will be deleted and its classname and position will be used for the spawned pequod.
Adding other scripts, settings, etc. to it will be pointless.
 
 landed: default false
 If true, it means you placed the example helicopter in a landed position.
 The scripts might eventually support landing at this location as a default base, but for now it's useless.
 
 respawn: default false
 If true, the spawned pequod helicopter will act as a spawnpoint for every side.
 Later versions might support specifying a side.
 
 curator: default null
 If you specify the variable name of a curator logic, it will be used to provide "ACC" functionality to pequod.
 Any player inside pequod can use an action to "connect" and play as the curator, then "disconnect" to let someone else use it.
 Exiting pequod will disconnect you.
 
 
Pequod is useless without commands, and the easiest way to make pequod controllable is to make a radio trigger:

Create a trigger in the editor with an activation of, eg, "Radio Alpha", set it to repeatable, and put this in the activation:

  ["menu"] call pequod_fnc_cmd;
 
By hitting 0, picking "Radio", and your new radio entry, you will get a detailed menu of all of pequod's functions.
If you want to use only limited functions of pequod, you can pass other strings to this function instead, here's a list of them:

"menu"        Command menu with all available commands.
"marker"      Opens the map and shows preplaced pequod objective markers to be clicked on.
"lzsmoke"     Opens a menu to specify a color of smoke for Pequod to land at. Pequod must be nearby to see the smoke.
"loiter"      Opens the map to let you click and specify a position for pequod to go to, then "loiter" around in a circle.
"hot"         Opens the map to let you click and specify a position for pequod to engage enemies at.
"fulton"      Tells pequod to look for a fulton balloon and attempt to pick it up.
"arsenal"     Opens the map to let you click and specify a position to drop a supply box with the virtual arsenal.
"smokescreen" Opens the map to let you click and specify a position to drop several smoke grenades.
"roe"         Opens a menu to configure rules of engagement and standard operating procedures for Pequod.



PEQUOD MARKERS:

By creating markers in the editor with names starting with "pequod_", you can define pre-planned objectives for Pequod.
These markers will be automatically hidden on mission start, and only show in the "marker" command map.
Supported types are as follows, and are defined by the marker text:

"Helicopter LZ"     Markers with this text will tell Pequod to land at this location. Add an invisible helipad and customize to your mission requirements.
"Helicopter Hover"  This very useless marker text will tell Pequod to hover completely still 6 meters above the ground. Helocasting!
"Helicopter RTB"    This overpowered marker text will tell Pequod to land and shut off his engines, also totally repairing the helicopter.



