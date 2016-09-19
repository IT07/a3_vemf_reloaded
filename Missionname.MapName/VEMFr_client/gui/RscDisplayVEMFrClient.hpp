class RscDisplayVEMFrClient
{
	idd = 2991;
	fadeIn = 0.2;
	fadeOut = 1;
	duration = 99999;
	onLoad = "uiNamespace setVariable ['RscDisplayVEMFrClient', _this select 0]; ExecVM 'VEMFr_client\sqf\RscDisplayVEMFrClient\onLoad.sqf'";
	onUnLoad = "uiNamespace setVariable ['RscDisplayVEMFrClient', displayNull]";
	class RscBackground
	{
		access = 0;
		colorBackground[] = {0.48,0.5,0.35,1};
		colorShadow[] = {0,0,0,0.5};
		colorText[] = {0.1,0.1,0.1,1};
		deletable = 0;
		fade = 0;
		fixedWidth = 0;
		font = "PuristaLight";
		h = 1;
		idc = -1;
		linespacing = 1;
		shadow = 0;
		SizeEx = 1;
		style = 512;
		text = "";
		tooltipColorBox[] = {1,1,1,1};
		tooltipColorShade[] = {0,0,0,0.65};
		tooltipColorText[] = {1,1,1,1};
		type = 0;
		w = 1;
		x = 0;
		y = 0;
	};
	class RscPictureKeepAspect
	{
		access = 0;
		colorBackground[] = {0,0,0,1};
		colorText[] = {1,1,1,1};
		deletable = 0;
		fade = 0;
		fixedWidth = 0;
		font = "PuristaMedium";
		h = 0.15;
		idc = -1;
		lineSpacing = 0;
		shadow = 0;
		sizeEx = 0;
		style = "0x30 + 0x800";
		text = "";
		tooltipColorBox[] = {1,1,1,1};
		tooltipColorShade[] = {0,0,0,0.65};
		tooltipColorText[] = {1,1,1,1};
		type = 0;
		w = 0.2;
		x = 0;
		y = 0;
	};
	class RscText
	{
		access = 0;
		colorBackground[] = {0.071,0.078,0.094,1};
		colorShadow[] = {0,0,0,0.5};
		colorText[] = {0.22,0.745,0.882,1};
		deletable = 0;
		fade = 0;
		fixedWidth = 0;
		font = "PuristaMedium";
		h = 0.037;
		idc = -1;
		linespacing = 1;
		shadow = 1;
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		style = 0;
		text = "";
		tooltipColorBox[] = {1,1,1,1};
		tooltipColorShade[] = {0,0,0,0.65};
		tooltipColorText[] = {1,1,1,1};
		type = 0;
		w = 0.3;
		x = 0;
		y = 0;
	};
	class controls
	{
		class icon:RscPictureKeepAspect
		{
			x = 0.25 * safezoneW + safezoneX;
			y = 0.825 * safezoneH + safezoneY;
			w = 0.025 * safezoneW;
			h = 0.05 * safezoneH;

			fade = 1;
			idc = 10;
			text = "\A3\ui_f\data\map\markers\nato\o_art.paa";
		};
		class txtTitle: RscText
		{
			x = 0.2875 * safezoneW + safezoneX;
			y = 0.8235 * safezoneH + safezoneY;
			w = 0 * safezoneW;
			h = 0.02 * safezoneH;

			colorBackground[] = {0,0,0,0.75};
			colorText[] = {1,1,1,0.9};
			fade = 1;
			idc = 11;
			shadow = 0;
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
			text = "";
		};
		class txtMsg: RscText
		{
			x = 0.2875 * safezoneW + safezoneX;
			y = 0.845 * safezoneH + safezoneY;
			w = 0 * safezoneW;
			h = 0.03 * safezoneH;

			colorBackground[] = {0,0,0,0.75};
			colorText[] = {1,1,1,0.9};
			fade = 1;
			idc = 12;
			shadow = 0;
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.25)";
			text = "";
		};
	};
};
