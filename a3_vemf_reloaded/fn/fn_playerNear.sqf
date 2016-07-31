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

private [("_r"),("_this0"),("_this1")];
// By default, we assume that there are no players close. The distance check below should prove otherwise if there are players close
_r = false;
params [
   [("_this0"),([]),([[]])],
   [("_this1"),(-1),([0])]
];
if (((count _this0) isEqualTo 3) AND (_this1 > -1)) then
   {
      scopeName "find";
      {
         if ((isPlayer _x) AND ((speed _x) < 250)) then
            {
               if ((position _x distance _this0) < _this1) then { _r = true; breakOut "find" };
            };
      } forEach allPlayers;
   };

_r
