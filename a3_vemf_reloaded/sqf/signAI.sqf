/*
    Author: IT07

    Description:
    marks given group(!) as VEMF AI which will then be used by REMOTEguard for monitor of groupOwner

    Params:
    _this: ARRAY
    _this select 0: GROUP - group to sign as VEMF AI

    Returns:
    nothing
*/

private "_grp";
_grp = param [0, grpNull, [grpNull]];
_grp setVariable [("isVEMFrGroup"),(true),(true)];
_grp setVariable [("isVEMFrGroupLocal"),(true),(true)];
