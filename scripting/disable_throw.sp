#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#pragma newdecls required
#define VERSION "1.0.0"

public Plugin myinfo =
{
  name        = "Disable throw",
  author      = "Black Star",
  description = "Prevents players from using the throw weapon action",
  version     = VERSION,
  url         = ""
};

public Action OnPlayerRunCmd(int client, int &buttons)
{
  char weaponClassname[32];

  if (!(buttons & IN_ATTACK2))
    return Plugin_Continue;

  int clientWeapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");

  if (clientWeapon < 0 || !GetEntityClassname(clientWeapon, weaponClassname, sizeof(weaponClassname)))
    return Plugin_Continue;

  if (IsThrowableWeapon(weaponClassname))
  {
    buttons &= ~IN_ATTACK2;
    return Plugin_Changed;
  }

  return Plugin_Continue;
}

stock bool IsThrowableWeapon(const char[] classname)
{
  return (
    StrEqual(classname, "weapon_spanner")
    || StrEqual(classname, "weapon_axe")
    || StrEqual(classname, "weapon_hammer"));
}