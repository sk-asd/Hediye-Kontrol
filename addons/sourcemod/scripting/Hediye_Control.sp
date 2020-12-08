#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
    name = "Hediye Kontrol", 
    author = "phiso", 
    description = "...", 
    version = "1.0", 
    url = "phiso#3331"
};

ConVar max_kredi = null, min_kredi = null;

public void OnPluginStart()
{
	AddCommandListener(Listener_Hediye, "sm_hediye");
	AddCommandListener(Listener_Hediye, "sm_gift");
	min_kredi = CreateConVar("hediye_min_kredi", "50", "En az kaç kredi hediye atsın", 0, true, 0.0);
	max_kredi = CreateConVar("hediye_max_kredi", "1500", "En fazla kaç kredi hediye atsın", 0, true, 1.0);
}

public Action Listener_Hediye(int client, const char[] command, int args)
{
	if (client > 0)
	{
		if (args != 2)
		{
			ReplyToCommand(client, "[SM] Kullanım: sm_hediye <Hedef> < %d - %d >", min_kredi.IntValue, max_kredi.IntValue);
			return Plugin_Stop;
		}
		else
		{
			char arg2[32];
			GetCmdArg(2, arg2, sizeof(arg2));
			if (StringToInt(arg2) < min_kredi.IntValue || StringToInt(arg2) > max_kredi.IntValue)
			{
				ReplyToCommand(client, "[SM] Kullanım: sm_hediye <Hedef> < %d - %d >", min_kredi.IntValue, max_kredi.IntValue);
				return Plugin_Stop;
			}
			return Plugin_Continue;
		}
	}
	return Plugin_Continue;
} 