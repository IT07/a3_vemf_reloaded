/*
   Author: IT07

   Description:
   handles the things that need to be done when RscDisplayBaseAttack is active
*/

disableSerialization;
_dsp = uiNamespace getVariable [ "RscDisplayBaseAttack", displayNull ];
if not ( isNull _dsp ) then
   {
      _dsp setVariable [ "doFlash", true ];
      while { not ( isNull _dsp ) } do
         {
            if ( _dsp getVariable [ "doFlash", false ] ) then
               {
                  _dsp setVariable [ "doingFlash", true ];
                  uiSleep 1.5;
                  {
                     _x ctrlSetFade 1; _x ctrlCommit 0.25;
                     uiSleep 0.25;
                  } forEach ( allControls _dsp );
                  uiSleep 0.5;
                  {
                     _x ctrlSetFade 0; _x ctrlCommit 0.25;
                     uiSleep 0.25;
                  } forEach ( allControls _dsp );
                  _dsp setVariable [ "doingFlash", false ];
               } else { uiSleep 0.5 };
         };
   };
