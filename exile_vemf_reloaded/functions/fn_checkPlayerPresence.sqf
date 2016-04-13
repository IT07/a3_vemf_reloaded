/*
    Author: IT07

    Description:
    checks for players within given distance of given location/position

    Params:
    _this select 0: POSITION - center of area to check around
    _this select 1: SCALAR - radius around the position to check for players

    Returns:
    BOOL - true if player(s) found
*/

private ["_pos","_found"];
// By default, we assume that there are no players close. The distance check below should prove otherwise if there are players close
_found = false;
_pos = param [0, [], [[]]];
if (count _pos isEqualTo 3) then
{
   private ["_rad"];
   _rad = param [1, -1, [0]];
   if (_rad > -1) then
   { // Check all player distances from _loc
      if (count allPlayers > 0) then
      {
         {
            if (isPlayer _x) then
            {
               if (speed _x < 250) then // Ignore fast moving players
               {
                  private ["_isClose"];
                  _isClose = if ((position _x distance _pos) < _rad) then { true } else { false };
                  if _isClose then { _found = true };
               };
            };
         } forEach allPlayers;
      };
   };
};

_found
