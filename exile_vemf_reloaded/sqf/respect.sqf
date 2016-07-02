/*
   Author: IT07
   Description:
   handles giving respect to players after killing AI
   Params:
   _this select 0: OBJECT - the AI that was killed
   _this select 1: OBJECT - the killer (must be a player)
*/

params [
   ["_t", objNull, [objNull]],
   ["_k", objNull, [objNull]]
];

_rw = "respectReward" call VEMFr_fnc_config;
if (_rw > 0) then
{
   _arr = [[]];
   (_arr select 0) pushBack [(selectRandom ["AI WACKED","AI CLIPPED","AI DISABLED","AI DISQUALIFIED","AI WIPED","AI ERASED","AI LYNCHED","AI WRECKED","AI NEUTRALIZED","AI SNUFFED","AI WASTED","AI ZAPPED"]), _rw];
   _dist = _t distance _k;
   private ["_ok"];
   if (_dist < 2500) then
   {
      scopeName "below2500";
      if (_dist <= 5) then
      {
         (_arr select 0) pushBack ["CQB Master", 25];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist <= 10) then
      {
         (_arr select 0) pushBack ["Close one", 15];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist <= 50) then
      {
         (_arr select 0) pushBack ["Danger close", 15];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist <= 100) then
      {
         (_arr select 0) pushBack ["Lethal aim", 20];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist <= 200) then
      {
         (_arr select 0) pushBack ["Deadly.", 25];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist <= 500) then
      {
         (_arr select 0) pushBack ["Niiiiice.", 30];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist <= 1000) then
      {
         (_arr select 0) pushBack ["Dat distance...", 45];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist <= 2000) then
      {
         (_arr select 0) pushBack ["Danger far.", 50];
         _ok = true;
         _ok breakOut "below2500";
      };
      if (_dist > 2000) then
      {
         (_arr select 0) pushBack [format["hax? %1m!!!", round _dist], 65];
         _ok = true;
         _ok breakOut "below2500";
      };
   };

   if _ok then
   {
      _crRspct = _k getVariable ["ExileScore", nil];
      _rspctTGv = (((_arr select 0) select 1) select 1);
      _nwRspct = _crRspct + _rspctTGv + _rw;
      _k setVariable ["ExileScore", _nwRspct];
      ExileClientPlayerScore = _nwRspct;
      (owner _k) publicVariableClient "ExileClientPlayerScore";
      ExileClientPlayerScore = nil;
      [_k, "showFragRequest", _arr] call ExileServer_system_network_send_to;
      format["setAccountMoneyAndRespect:%1:%2:%3", _k getVariable ["ExileMoney", 0], _nwRspct, (getPlayerUID _k)] call ExileServer_system_database_query_fireAndForget;
   } else
   {
      ["handleKillMessage", 0, format["There is something wrong with the kill distance (%1)", _dist]] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
      breakOut "outer"; // Stop doing anything after this line
   };
};
