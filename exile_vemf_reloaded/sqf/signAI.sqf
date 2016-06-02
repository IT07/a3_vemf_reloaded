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

_group = param [0, grpNull, [grpNull]];
if not isNull _group then
{
    (uiNamespace getVariable ["VEMFrAIgroups",[]]) pushBack _group;
    {
      _x setVariable ["VEMFrAIunit", 1, true];
    } forEach (units _group);
} else
{
   ["signAI", 0, "_group isNull"] ExecVM "exile_vemf_reloaded\sqf\log.sqf";
};
