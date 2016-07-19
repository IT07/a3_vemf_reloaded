/*
   Author: IT07

   Description:
   returns the script path of given string

   Returns:
   STRING - path to sqf file
*/

private "_r";
_r = getText (configFile >> "CfgVemfrScripts" >> _this);
_r
