/*
    Author: IT07

    Description:
    marks given group(!) as VEMF AI which will then be used by REMOTEguard for monitor of groupOwner

    Params:
    _this: ARRAY
    _this select 0: GROUP - group to sign as VEMF AI

    Returns:
    BOOL - true if OK
*/

private ["_ok","_group"];
_ok = false;
_group = param [0, grpNull, [grpNull]];
if not isNull _group then
{
    (uiNamespace getVariable "vemfGroups") pushBack _group;
    _ok = true
};

_ok
