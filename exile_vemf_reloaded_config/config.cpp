class CfgPatches
{
	class exile_vemf_reloaded_config
	{
		units[] = {};
		requiredAddons[] = {"exile_server"};
		fileName = "exile_vemf_reloaded_config.pbo";
		author = "IT07";
	};
};

class CfgVemfReloadedOverrides
{
   #include "config_override.cpp"
};
