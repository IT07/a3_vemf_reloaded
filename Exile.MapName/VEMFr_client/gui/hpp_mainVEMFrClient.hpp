class RscDisplayVEMFrClient
{
	idd = 2991;
	fadeIn = 0.2;
	fadeOut = 1;
	duration = 99999;
	onLoad = "uiNamespace setVariable ['RscDisplayVEMFrClient', _this select 0]";
	movingEnable = 0;
	class IGUIBack
	{
		type = 0;
		text = "";
		colorText[] = {0,0,0,0};
		font = "PuristaMedium";
		sizeEx = 0;
		shadow = 0;
		style = 128;
		colorBackground[] = {0,0,0,1};
	};
	class RscText
	{
		shadow = 0;
		deletable = 0;
		fade = 0;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		font = "PuristaLight";
		style = 0;
		access = 0;
		type = 0;
		fixedWidth = 0;
		colorShadow[] = {0,0,0,0.5};
		lineSpacing = 1;
		tooltipColorText[] = {1,1,1,0.9};
		tooltipColorBox[] = {1,1,1,0.2};
		tooltipColorShade[] = {0,0,0,0.7};
		colorText[] = {0.22,0.745,0.882,1};
		colorBackground[] = {0.071,0.078,0.094,1};
	};
	class controls
	{
		#include "hpp_rscVEMFrClient.hpp"
	};
};
