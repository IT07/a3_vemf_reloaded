// Put this somewhere in your own init.sqf outside of any other brackets and if statements
if hasInterface then
{
	[] ExecVM "VEMFr_client\sqf\initClient.sqf"; // Client-side part of VEMFr
};
