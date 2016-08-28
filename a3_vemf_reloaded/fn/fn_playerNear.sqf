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

private _r = false;
params [ "_this0", "_this1" ];
{
   if ( ( isPlayer _x ) AND ( ( speed _x ) < 250 ) AND ( ( ( position _x ) distance _this0 ) < _this1 ) ) exitWith { _r = true };
} forEach allPlayers;
_r
