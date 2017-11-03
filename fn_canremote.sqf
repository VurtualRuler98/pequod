_ply = param [0,objNull,[objNull]];
_canremote = false;
{if (_x in assignedItems _ply || _x == backpack _ply) exitWith {_canremote=true}} forEach pequod_var_remotes;
_canremote
