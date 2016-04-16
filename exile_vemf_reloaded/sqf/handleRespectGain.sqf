_target = param [0, objNull, [objNull]];
_killer = param [1, objNull, [objNull]];
if not(isNull _target AND isNull _killer) then
{
   scopeName "outer";
   _respectReward = "respectReward" call VEMFr_fnc_getSetting;
   if (_respectReward > 1) then
   {
      _message = [[]];
      _killMsg = selectRandom ["AI WACKED","AI CLIPPED","AI DISABLED","AI DISQUALIFIED","AI WIPED","AI ERASED","AI LYNCHED","AI WRECKED","AI NEUTRALIZED","AI SNUFFED","AI WASTED","AI ZAPPED"];
      (_message select 0) pushBack [_killMsg,_respectReward];
      _dist = _target distance _killer;
      private ["_distanceOk"];
      if (_dist < 2500) then
      {
         scopeName "below2500";
         if (_dist <= 5) then
         {
            (_message select 0) pushBack ["CQB Master", 25];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist <= 10) then
         {
            (_message select 0) pushBack ["Close one", 15];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist <= 50) then
         {
            (_message select 0) pushBack ["Danger close", 15];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist <= 100) then
         {
            (_message select 0) pushBack ["Lethal aim", 20];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist <= 200) then
         {
            (_message select 0) pushBack ["Deadly.", 25];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist <= 500) then
         {
            (_message select 0) pushBack ["Niiiiice.", 30];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist <= 1000) then
         {
            (_message select 0) pushBack ["Dat distance...", 45];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist <= 2000) then
         {
            (_message select 0) pushBack ["Danger far.", 50];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
         if (_dist > 2000) then
         {
            (_message select 0) pushBack [format["hax? %1m!!!", round _dist], 65];
            _distanceOk = true;
            _distanceOk breakOut "below2500";
         };
      };

      if _distanceOk then
      {
         _curRespect = _killer getVariable ["ExileScore", nil];
         if not(isNil"_curRespect") then
         {
            _respectToGive = (((_message select 0) select 1) select 1);
            _newRespect = _curRespect + _respectToGive + _respectReward;
            _killer setVariable ["ExileScore", _newRespect];
            ExileClientPlayerScore = _newRespect;
            (owner _killer) publicVariableClient "ExileClientPlayerScore";
            ExileClientPlayerScore = nil;
            [_killer, "showFragRequest", _message] call ExileServer_system_network_send_to;
            format["setAccountMoneyAndRespect:%1:%2:%3", _killer getVariable ["ExileMoney", 0], _newRespect, (getPlayerUID _killer)] call ExileServer_system_database_query_fireAndForget;
         } else
         {
            ["fn_aiKilled", 0, format["Failed to get respect from %1 (%2)", name _killer, _killer]] spawn VEMFr_fnc_log;
         };
      } else
      {
         ["handleKillMessage", 0, format["There is something wrong with the kill distance (%1)", _dist]] spawn VEMFr_fnc_log;
         breakOut "outer"; // Stop doing anything after this line
      };
   };
};
