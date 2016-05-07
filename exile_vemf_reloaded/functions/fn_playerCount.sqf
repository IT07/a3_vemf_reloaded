/*
    Author: IT07

    Description:
    checks if player count is above or equal to given number. If no number given, default of 1 will be used.

    Params:
    none

    Returns:
    ARRAY - [false if current player count is below minimum, true if (more than OR equalTo) minimum]
*/

private ["_ok"];
_ok = false;
if (_this isEqualType []) then
{
   private ["_minimum"];
   _minimum = param [0, 1, [0]];
   _players = 0;
   {
      if (isPlayer _x) then
         {
            _players = _players + 1;
         };
   } forEach allPlayers;
   if (_players >= _minimum) then
   {
      _ok = true
   };
};

_ok
