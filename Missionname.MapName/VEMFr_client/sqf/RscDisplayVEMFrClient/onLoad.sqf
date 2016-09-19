disableSerialization;
_dsp = uiNamespace getVariable [ "RscDisplayVEMFrClient", displayNull ];
if not isNull _dsp then
   {
      if ( count ( uiNamespace getVariable [ "VEMFrMsgQueue", [] ] ) isEqualTo 0 ) then
         {
            ( [ "RscDisplayVEMFrClient" ] call BIS_fnc_rscLayer ) cutFadeOut 0;
            systemChat "[VEMFrClient] No messages to display";
         } else
         {
            playSound "HintExpand";
            // do stuff
            _ctrlPic = _dsp displayCtrl 10;
            _ctrlTitle = _dsp displayCtrl 11;
            _ctrlMsg = _dsp displayCtrl 12;
            {
               [ _dsp, _x ] spawn
               {
                  disableSerialization;
                  _dsp = _this select 0;
                  _data = _this select 1;
                  _ctrlPic = _dsp displayCtrl 10;
                  if ( ( ctrlFade _ctrlPic ) < 1 ) then
                     {
                        _ctrlPic ctrlSetFade 1;
                        _ctrlPic ctrlCommit 0.5;
                        uiSleep 0.75;
                     };
                  _ctrlPic ctrlSetTextColor call
                     {
                        private _a = getArray ( configFile >> "CfgMarkerColors" >> ( _data select 0 ) >> "color" );
                        {
                           if ( _x isEqualType "" ) then { _a set [ _forEachIndex, call compile _x ] };
                        } forEach _a;
                        _a
                     };
                  _ctrlPic ctrlSetFade 0;
                  _ctrlPic ctrlCommit 0.5;
               };

               if ( _ctrlTitle getVariable [ "expanded", false ] AND ( _ctrlMsg getVariable [ "expanded", false ] ) ) then
                  {
                     _ctrlPos = ctrlPosition _ctrlTitle;
                     _ctrlTitle ctrlSetPosition [ _ctrlPos select 0, _ctrlPos select 1, 0 * safezoneW, _ctrlPos select 3 ];
                     _ctrlTitle ctrlSetFade 1;
                     _ctrlTitle ctrlCommit 0.5;
                     _ctrlTitle setVariable [ "expanded", false ];
                     uiSleep 0.75;
                     _ctrlTitle ctrlSetText toUpper ( _x select 1 );
                     _ctrlPos = ctrlPosition _ctrlTitle;
                     _ctrlTitle ctrlSetPosition [ _ctrlPos select 0, _ctrlPos select 1, 0.1 * safezoneW, _ctrlPos select 3 ];
                     _ctrlTitle ctrlSetFade 0;
                     _ctrlTitle ctrlCommit 0.5;
                     _ctrlTitle setVariable [ "expanded", true ];

                     _ctrlPos = ctrlPosition _ctrlMsg;
                     _ctrlMsg ctrlSetPosition [ _ctrlPos select 0, _ctrlPos select 1, 0 * safezoneW, _ctrlPos select 3 ];
                     _ctrlMsg ctrlSetFade 1;
                     _ctrlMsg ctrlCommit 0.5;
                     _ctrlMsg setVariable [ "expanded", false ];
                     uiSleep 0.75;
                     _ctrlMsg ctrlSetText ( _x select 2 );
                     _ctrlPos = ctrlPosition _ctrlMsg;
                     _ctrlMsg ctrlSetPosition [ _ctrlPos select 0, _ctrlPos select 1, 0.425 * safezoneW, _ctrlPos select 3 ];
                     _ctrlMsg ctrlSetFade 0;
                     _ctrlMsg ctrlCommit 0.5;
                     _ctrlMsg setVariable [ "expanded", true ];

                     uiSleep ( count ( _x select 2 ) / 5 );
                  } else
                  {
                     _ctrlTitle ctrlSetText toUpper ( _x select 1 );
                     _ctrlPos = ctrlPosition _ctrlTitle;
                     _ctrlTitle ctrlSetPosition [ _ctrlPos select 0, _ctrlPos select 1, 0.1 * safezoneW, _ctrlPos select 3 ];
                     _ctrlTitle ctrlSetFade 0;
                     _ctrlTitle ctrlCommit 0.5;
                     _ctrlTitle setVariable [ "expanded", true ];

                     _ctrlMsg ctrlSetText ( _x select 2 );
                     _ctrlPos = ctrlPosition _ctrlMsg;
                     _ctrlMsg ctrlSetPosition [ _ctrlPos select 0, _ctrlPos select 1, 0.425 * safezoneW, _ctrlPos select 3 ];
                     _ctrlMsg ctrlSetFade 0;
                     _ctrlMsg ctrlCommit 0.5;
                     _ctrlMsg setVariable [ "expanded", true ];

                     uiSleep ( count ( _x select 2 ) / 5 );
                  };
            } forEach ( uiNamespace getVariable [ "VEMFrMsgQueue", [] ] );
            uiNamespace setVariable [ "VEMFrMsgQueue", [] ];
            ( [ "RscDisplayVEMFrClient" ] call BIS_fnc_rscLayer ) cutFadeOut 0.5;
         };
   } else { systemChat "Nope." };
