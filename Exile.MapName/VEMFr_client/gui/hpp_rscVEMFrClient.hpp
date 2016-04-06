class txtType: RscText
{
	idc = 1002;
	font = "PuristaSemiBold";
	text = "";
	colorText[] = {0,0,0,0.9};
	colorBackground[] = {1,1,1,0.9};
	x = 0.25 * safezoneW + safezoneX;
	y = 0.88 * safezoneH + safezoneY;
	w = 0 * safezoneW;
	h = 0.02 * safezoneH;
};
class txtTag: RscText
{
	idc = 1001;
	font = "PuristaBold";
	text = "";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.3)";
	colorText[] = {0,0,0,0.9};
	colorBackground[] = {1,1,1,0.9};
	x = 0.25 * safezoneW + safezoneX;
	y = 0.9 * safezoneH + safezoneY;
	w = 0.05 * safezoneW;
	h = 0 * safezoneH;
};
class txtMsg: RscText
{
	idc = 1000;
	text = "";
	colorText[] = {1,1,1,0.9};
	colorBackground[] = {0,0,0,0.9};
	x = 0.3 * safezoneW + safezoneX;
	y = 0.9 * safezoneH + safezoneY;
	w = 0 * safezoneW;
	h = 0.03 * safezoneH;
};
