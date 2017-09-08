_trg = createTrigger ["EmptyDetector",[0,0,0],false];
_trg setTriggerActivation ["ALPHA","",true];
_trg setTriggerType "NONE";
_trg setTriggerStatements ["this","['menu'] spawn pequod_fnc_cmd",""];
_trg setTriggerText	"Contact Pequod";
