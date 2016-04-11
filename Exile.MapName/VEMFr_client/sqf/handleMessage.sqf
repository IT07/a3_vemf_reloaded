_txt = param [0, "", [""]];
_type = param [1, "", [""]];
if not(_txt isEqualTo "") then
{
    _msgQueue = uiNamespace getVariable ["RscDisplayVEMFrClientMsgQueue", []];
    _msgQueue pushBack _txt;
    disableSerialization;
    _dsp = uiNamespace getVariable ["RscDisplayVEMFrClient", displayNull];
    _doAnim =
    {
        for "_g" from 1 to (count _txt) do
        {
            _ctrl ctrlSetText (_txt select [0, _g]);
            if isNull (findDisplay 49) then
            {
                if not isNull _dsp then
                {
                    playSound ["ReadOutClick", true];
                };
            };
            uiSleep 0.05;
        };
        _chars = [];
        for "_t" from 1 to (count _txt) do
        {
            _char = _txt select [_t, 1];
            _chars pushBack _char;
        };
        _writeThis = +_chars;
        uiSleep ((count _txt)/6);
        for "_i" from (count _chars) to 1 step -1 do
        {
            _charID = floor random count _chars;
            _deleted = _chars deleteAt _charID;
            if not(_deleted isEqualTo "") then
            {
                _charToSet = _writeThis find _deleted;
                if not(_deleted isEqualTo " ") then
                {
                    _binaries = ["0","1"];
                    _writeThis set [_charToSet, _binaries select floor random count _binaries];
                };
                _string = "";
                {
                    _string = _string + _x;
                } forEach _writeThis;
                _ctrl ctrlSetText _string;
                if isNull(findDisplay 49) then
                {
                    if not isNull _dsp then
                    {
                        playSound ["ReadOutHideClick1", true];
                    };
                };
                uiSleep 0.05;
            };
        };

        if (typeName _msgQueue isEqualTo "ARRAY") then
        {
            _index = _msgQueue find _txt;
            if (_index > -1) then
            {
                _msgQueue deleteAt _index;
            };
        };

        if (count _msgQueue isEqualTo 0) then
        {
            _ctrl ctrlSetPosition [(ctrlPosition _ctrl) select 0, (ctrlPosition _ctrl) select 1, 0 * safezoneW, (ctrlPosition _ctrl) select 3];
            _ctrl ctrlCommit 0.5;
            uiSleep 0.5;
            _ctrlTag ctrlSetPosition [(ctrlPosition _ctrlTag) select 0, (ctrlPosition _ctrlTag) select 1, (ctrlPosition _ctrlTag) select 2, 0 * safezoneH];
            _ctrlTag ctrlCommit 0.3;
            _ctrlTag ctrlSetText "";
            uiSleep 0.3;
            _ctrlMsgType ctrlSetPosition [(ctrlPosition _ctrlMsgType) select 0, (ctrlPosition _ctrlMsgType) select 1, 0 * safezoneW, (ctrlPosition _ctrlMsgType) select 3];
            _ctrlMsgType ctrlCommit 0.3;
            uiSleep 0.3;
            (["RscDisplayVEMFrClient"] call BIS_fnc_rscLayer) cutFadeOut 0.3;
        };
    };
    if isNull _dsp then
    { // Make sure the display is actually active
        (["RscDisplayVEMFrClient"] call BIS_fnc_rscLayer) cutRsc["RscDisplayVEMFrClient", "PLAIN", 0, true];
        _dsp = uiNamespace getVariable ["RscDisplayVEMFrClient", displayNull];
        if ((count _msgQueue) > 0) then
        {
            _ctrlMsgType = _dsp displayCtrl 1002;
            _ctrlMsgType ctrlSetText _type;
            _ctrlMsgType ctrlSetPosition [(ctrlPosition _ctrlMsgType) select 0, (ctrlPosition _ctrlMsgType) select 1, 0.1 * safezoneW, (ctrlPosition _ctrlMsgType) select 3];
            _ctrlMsgType ctrlCommit 0.3;
            uiSleep 0.3;
            _ctrlTag = _dsp displayCtrl 1001;
            _ctrlTag ctrlSetPosition [(ctrlPosition _ctrlTag) select 0, (ctrlPosition _ctrlTag) select 1, (ctrlPosition _ctrlTag) select 2, 0.03 * safezoneH];
            _ctrlTag ctrlCommit 0.3;
            uiSleep 0.3;
            _ctrlTag ctrlSetText toString [91,86,69,77,70,93];
            _ctrl = _dsp displayCtrl 1000;
            _ctrl ctrlSetPosition [(ctrlPosition _ctrl) select 0, (ctrlPosition _ctrl) select 1, 0.4375 * safezoneW, (ctrlPosition _ctrl) select 3];
            _ctrl ctrlCommit 0.3;
            uiSleep 0.3;
            call _doAnim;
        };
    };
    if not isNull _dsp then
    {
        waitUntil { uiSleep 1; (_msgQueue select 0) isEqualTo _txt };
        if not isNull _dsp then
        {
            _ctrlMsgType = _dsp displayCtrl 1002;
            _ctrlMsgType ctrlSetText _type;
            _ctrlTag = _dsp displayCtrl 1001;
            _ctrl = _dsp displayCtrl 1000;
            call _doAnim;
        };
    };
};
