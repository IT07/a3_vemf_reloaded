/*
   Author: IT07

   Description:
   returns the current server mod (Exile or Epoch)

   Returns:
   STRING - the name of the current server mod
*/

private "_r";

if not(isNull(configFile >> "CfgPatches" >> "exile_server")) then { _r = "Exile" };
if not(isNull(configFile >> "CfgPatches" >> "a3_epoch_server")) then { _r = "Epoch" };

_r
