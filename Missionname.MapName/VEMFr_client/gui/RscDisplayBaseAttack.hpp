class RscDisplayBaseAttack
{
   duration = 99999;
   fadeIn = 0.2;
   fadeOut = 1;
   idd = 2992;
   onLoad = "uiNamespace setVariable ['RscDisplayBaseAttack', _this select 0]; ExecVM 'VEMFr_client\sqf\RscDisplayBaseAttack\onLoad.sqf'";
   onUnLoad = "uiNamespace setVariable ['RscDisplayBaseAttack', displayNull]";

   class RscText
	{
		access = 0;
		colorBackground[] = {0.071, 0.024, 0.024, 0.75};
		colorShadow[] = {0, 0, 0, 0.5};
		colorText[] = {1, 0.333, 0.333, 1};
		deletable = 0;
		fade = 0;
		fixedWidth = 0;
		font = "PuristaMedium";
		h = 0.037;
		idc = -1;
		linespacing = 1;
		shadow = 1;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		style = 2;
		text = "";
		tooltipColorBox[] = {1, 1, 1, 1};
		tooltipColorShade[] = {0, 0, 0, 0.65};
		tooltipColorText[] = {1, 1, 1, 1};
		type = 0;
		w = 0.3;
		x = 0;
		y = 0;
	};

   class controls
   {
      class text:RscText {
         x = 0.4 * safezoneW + safezoneX;
			y = 0.88 * safezoneH + safezoneY;
			w = 0.2 * safezoneW; //w = 0.35 * safezoneW;
			h = 0.0275 * safezoneH;

         font = "PuristaBold";
         idc = 1;
         shadow = 0;
         text = " // [ WARNING! Base is under attack ] \\";
      };
   };
};
