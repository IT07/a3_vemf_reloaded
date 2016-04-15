# ArmA3_exile_vemf_reloaded
**Not to confuse with VEMF** <br /><br />

#### How to download?
**Because of its new location, the download process is a little different:** <br />
Click the .7z file and then click the "Raw" button. You will then get the exile_vemf_reloaded folder and the Exile.MapName folder inside of a packed .7z :) <br />
<br />

#### How to install?
**Server-side files** <br />
- copy the `exile_vemf_reloaded` folder over into where your server's `@ExileServer\addons\` folder is located.<br />
- navigate into the `exile_vemf_reloaded` folder that you just copied over into your server. <br />
- open the config.cpp and READ IT. There is A LOT of settings in there that you can adjust to change VEMFr. <br />
- when done changing stuff in the config.cpp, simply pack **the contents(!)** of the parent folder into a pbo called `exile_vemf_reloaded` <br />
- you can delete the `exile_vemf_reloaded` folder that the program you use to pack into a pbo might have left behind. You don't have to though. <br />
<br />
**Client-side files** <br />
- whatever your server setup might be, you need to open/download/unpack your server's mission file. If you are running the Altis map for example, it will be a .pbo called `Exile.Altis`.
Or when you are running Esseker for example, then it will be `Exile.Esseker`. Normally that file is located inside the *mpmissions* folder which is in the root of your server's installation path.
Simply unpack that file and go into the folder that comes out of it. There should be a file called `description.ext` in there. Open that.
Then look for a line that says `class CfgFunctions`. If you can not find it, then add this somewhere near the bottom of your description.ext: <br />
Try and find it in your description.ext, if it is not there, then just simply add this to the bottom of your description.ext:<br />
```
class RscTitles
{
	#include "VEMFr_client\gui\RscDisplayVEMFrClient.hpp"
};
```
<br />
BUT, if you DO have a `class RscTitles` already, then just make a new line just before the `};` and then put this on that new line:<br />
`#include "VEMFr_client\gui\RscDisplayVEMFrClient.hpp"`<br />
Just an example of how it would look with other stuff in between the brackets of `class RscTitles`:<br />
```
class RscTitles
{
    #include "some\other\scriptszzzzz\file.hpp"
    #include "bla\addons\dialog.hpp"
    #include "addons\scripts\gui\someFile.hpp"
    #include "VEMFr_client\gui\RscDisplayVEMFrClient.hpp"
};
```
<br />
Now, the last part: *init.sqf*.<br />
- open the init.sqf that is located inside *Exile.MapName* and simply follow the instructions that are inside that file. <br />
<br />

*Done!*
