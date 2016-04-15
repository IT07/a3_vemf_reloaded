_target = param [0, objNull, [objNull]];
_killer = param [1, objNull, [objNull]];
if not(isNull _target AND isNull _killer) then
{
   _respectReward = "respectReward" call VEMFr_fnc_getSetting;
   if (_respectReward > 1) then
   {
      _message = [[]];
      _killMsg = selectRandom ["AI WACKED","AI CLIPPED","AI DISABLED","AI DISQUALIFIED","AI WIPED","AI ERASED","AI LYNCHED","AI WRECKED","AI NEUTRALIZED","AI SNUFFED","AI WASTED","AI ZAPPED"];
      (_message select 0) pushBack [_killMsg,_respectReward];
      _dist = _target distance _killer;
      switch true do
      {
         case (_dist <= 5):
         {
            (_message select 0) pushBack ["CQB Master", 25]
         };
         case (_dist <= 10):
         {
            (_message select 0) pushBack ["Close one", 15]
         };
         case (_dist <= 50):
         {
            (_message select 0) pushBack ["Danger close", 15]
         };
         case (_dist <= 100):
         {
            (_message select 0) pushBack ["Lethal aim", 20]
         };
         case (_dist <= 200):
         {
            (_message select 0) pushBack ["Deadly.", 25]
         };
         case (_dist <= 500):
         {
            (_message select 0) pushBack ["Niiiiice.", 30]
         };
         case (_dist <= 1000):
         {
            (_message select 0) pushBack ["Dat distance...", 45]
         };
         case (_dist <= 2000):
         {
            (_message select 0) pushBack ["Danger far.", 50]
         };
         case (_dist > 2000):
         {
            (_message select 0) pushBack [format["hax? %1m!!!", round _dist], 65]
         };
      };
      _curRespect = _killer getVariable ["ExileScore", -1];
      if (_curRespect >= 0) then
      {
         //diag_log text format["_curRespect of _killer (%1) is %2", _killer, _curRespect];
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
         ["fn_aiKilled", 0, format["Failed to get respect from %1", _killer]] spawn VEMFr_fnc_log;
      };
   };

   _sayKilled = "sayKilled" call VEMFr_fnc_getSetting;
   if (_sayKilled > 0) then // Send kill message if enabled
   {
      _killer = param [1, objNull, [objNull]];
      _dist = _target distance _killer;
      if (_dist > 1) then
      {
         private ["_curWeapon"];
         if (vehicle _killer isEqualTo _killer) then // If on foot
         {
            _curWeapon = currentWeapon _killer;
         };
         if not(vehicle _killer isEqualTo _killer) then // If in vehicle
         {
            _curWeapon = currentWeapon (vehicle _killer);
         };
         if (_sayKilled isEqualTo 1) then
         {
            _kMsg = format["(VEMFr) %1 [%2, %3m] AI", name _killer, getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist];
            [_kMsg, "sys"] spawn VEMFr_fnc_broadCast;
         };
         if (_sayKilled isEqualTo 2) then
         {
            VEMFrClientMsg = [format["(VEMFr) You [%1, %2m] AI", getText(configFile >> "CfgWeapons" >> _curWeapon >> "displayName"), round _dist], "sys"];
            (owner _killer) publicVariableClient "VEMFrClientMsg";
            VEMFrClientMsg = nil;
         };
      };
   };
};
