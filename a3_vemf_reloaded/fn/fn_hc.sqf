/*
    Author: IT07

    Description:
    selects a headless client with least (VEMFr) load

    Params:
    None

    Returns:
    OBJECT - the headless client
*/

private [ "_r", "_n", "_arr", "_gl", "_hc" ];
_n = "headLessClientNames" call VEMFr_fnc_config;
_arr = [ ];
_gl = uiNamespace getVariable "VEMFrHcLoad";
{
   _hc = missionNameSpace getVariable [ _x, "nope" ];
   if not ( _hc isEqualTo "nope" ) then
      {
         if ( ( ( typeName _hc ) isEqualTo "OBJECT" ) AND ( ( toLower ( typeOf _hc ) ) isEqualTo ( toLower ( "HeadlessClient_F" ) ) ) ) then
            {
               _arr pushBackUnique _hc;
               if not ( _x in ( _gl select 0 ) ) then
                  {
                     _i = ( _gl select 0 ) pushBack _hc;
                     ( _gl select 1 ) set [ _i, 0 ];
                  };
            };
      };
} forEach _n;

if ( ( count _arr ) > 0 ) then
   {
      _l = 99999;
      { if ( _x <= _l ) then { _l = _x } } forEach ( _gl select 1 );
      _r = ( _gl select 0 ) select ( ( _gl select 1 ) find _l );
      ( _gl select 1 ) set [ ( _gl select 0 ) find _r, _l + 1 ];
      if not ( isNil "_r" ) then { _r };
   };
