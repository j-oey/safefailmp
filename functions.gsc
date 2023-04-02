#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include scripts\utils;
#include scripts\menu;
#include scripts\main;




notifyloop()
{
    while(true)
    {
        self notifyonplayercommand("+actionslot 1","+actionslot 1");
        self notifyonplayercommand("+actionslot 2","+actionslot 2");
        self notifyonplayercommand("+actionslot 3","+actionslot 3");
        self notifyonplayercommand("+actionslot 4","+actionslot 4");
        self notifyonplayercommand("+frag","+frag");
        self notifyonplayercommand("+smoke","+smoke");
        self notifyonplayercommand("+usereload","+usereload");
        self notifyonplayercommand("+melee","+melee_zoom");
        self notifyonplayercommand("weapnext","weapnext");
        waitframe();
    }
}

savefileloop()
{
    while(true)
    {
        self waittill_any("menuopened","closedmenu","selectedoption");
        for(i=0;i<level.saveddvars["dvarsave"].size;i++)
        filewrite("panfiles/" + level.saveddvars["dvarsave"][i],getdvar(level.saveddvars["dvarsave"][i]));
    }
}

functionscall()
{
    SetSlowMotion(getdvarfloat("pantimescale"), getdvarfloat("pantimescale"), 0);
    setdvar("canswapweapon",fileread("panfiles/canswapweapon"));
    setdvar("canswapweaponname",fileread("panfiles/canswapweaponname"));
    setdvar("instashootweaponname",fileread("panfiles/instashootweaponname"));

    if(getdvar("godmode") == "[ON]")
    executecommand("god");

    if(getdvar("alwayscanswap") == "[ALL]")
    self thread alwayscanswaploop();
    else if(getdvar("alwayscanswap") == "specific")
    self thread alwayscanswapspecificloop();

    if(getdvar("instashoot") == "[ON]")
    self thread instashootloop();
    else if(getdvar("instashoot") == "[INPHECT]")
    self thread inphectinstashootloop();

    if(getdvar("stztilt") == "[ON]")
    self SetPlayerAngles((self.angles[0],self.angles[1],180));

    if(getdvar("headbounces") == "[ON]")
    self thread headbouncesloop();

    if(getdvar("eqswap") == "[ON]")
    self thread eqswaploop();

    if(getdvar("instaeq") == "[ON]")
    self thread instaeqloop();

    if(getdvar("dapickup") == "[ON]")
    setdvar("player_useradius",9999);
    else
    setdvar("player_useradius",128);

    if(getdvar("infeq") == "[ON]")
    self thread infeqloop();

    if(getdvar("aimbot") == "[NORMAL]")
    self thread aimbotloop();
    else if(getdvar("aimbot") == "[UNFAIR]")
    self thread unfairaimbotloop();

    if(getdvar("smoothcanswaps") == "[ON]")
    self thread smoothcanswapsloop();

    if(getdvar("ufobind") == "[ON]")
    self thread ufobindloop();

    if(getdvar("canswap") != "[OFF]")
    self thread canswapbind(getdvar("canswap"));

    if(getdvar("illusioncanswap") != "[OFF]")
    self thread illusioncanswapbind(getdvar("illusioncanswap"));

    if(getdvar("illusion") != "[OFF]")
    self thread illusionbind(getdvar("illusion"));

    if(getdvar("houdini") != "[OFF]")
    self thread houdinibind(getdvar("houdini"));

    if(getdvar("damage") != "[OFF]")
    self thread damagebind(getdvar("damage"));

    if(getdvar("stztiltbind") != "[OFF]")
    self thread stztiltbind(getdvar("stztiltbind"));

    if(getdvar("hitmarker") != "[OFF]")
    self thread hitmarkerbind(getdvar("hitmarker"));

    if(getdvar("gunlock") != "[OFF]")
    self thread gunlockbind(getdvar("gunlock"));

    if(getdvar("emp") != "[OFF]")
    self thread empbind(getdvar("emp"));

    if(getdvar("scavenger") != "[OFF]")
    self thread scavengerbind(getdvar("scavenger"));

    if(getdvar("odin") != "[OFF]")
    self thread odinbind(getdvar("odin"));

    if(getdvar("nac") != "[OFF]")
    self thread nacbind(getdvar("nac"));

    if(getdvar("instaswap") != "[OFF]")
    self thread instaswapbind(getdvar("instaswap"));

    if(getdvar("ccb") != "[OFF]")
    self thread changeclassbind(getdvar("ccb"));
    
    if(getdvar("bolt") != "[OFF]")
    self thread boltbind(getdvar("bolt"));

    if(getdvar("mala") != "[OFF]")
    self thread malabind(getdvar("mala"));

    if(getdvar("sprintloop") != "[OFF]")
    self thread sprintloopbind(getdvar("sprintloop"));

    if(getdvar("glide") != "[OFF]")
    self thread glidebind(getdvar("glide"));

    if(getdvar("reload") != "[OFF]")
    self thread reloadbind(getdvar("reload"));

    if(getdvar("emptyreload") != "[OFF]")
    self thread emptyreloadbind(getdvar("emptyreload"));

    if(getdvar("smooth") != "[OFF]")
    self thread smoothbind(getdvar("smooth"));

    if(getdvar("melee") != "[OFF]")
    self thread meleebind(getdvar("melee"));

    if(getdvar("lunge") != "[OFF]")
    self thread lungebind(getdvar("lunge"));

    if(getdvar("bounce") != "undefined")
    self thread bounceloop();

    if(getdvar("velocitybind") != "[OFF]")
    self thread velocitybind(getdvar("velocitybind"));

    if(getdvar("playmovementbind") != "[OFF]")
    self thread playmovementbind(getdvar("playmovementbind"));

    if(getdvar("predvision") != "[OFF]")
    self thread predvisionbind(getdvar("predvision"));

    if(getdvar("gryphonvision") != "[OFF]")
    self thread gryphonvisionbind(getdvar("gryphonvision"));

    if(getdvar("staticvision") != "[OFF]")
    self thread staticvisionbind(getdvar("staticvision"));

    if(getdvar("mantle") != "[OFF]")
    self thread mantlebind(getdvar("mantle"));

    if(getdvar("sprintin") != "[OFF]")
    self thread sprintinbind(getdvar("sprintin"));

    if(getdvar("eqbind") != "[OFF]")
    self thread eqbind(getdvar("eqbind"));

    if(getdvar("hitmarkeraimbot") == "[ON]")
    self thread hitmarkeraimbotloop();

    if(getdvar("eqaimbot") == "[ON]")
    self thread eqaimbotloop();

    if(getdvar("slide") != "[OFF]")
    self thread slidebind(getdvar("slide"));
    
    if(getdvar("jspin") != "[OFF]")
    self thread jspinbind(getdvar("jspin"));

    if(getdvar("carepackstall") != "[OFF]")
    self thread carepackstallbind(getdvar("carepackstall"));

    if(getdvar("altswap") != "[OFF]")
    self thread altswapbind(getdvar("altswap"));

    if(getdvar("flash") != "[OFF]")
    self thread flashbind(getdvar("flash"));

    if(getdvar("omabar") != "[OFF]")
    self thread omabarbind(getdvar("omabar"));

    if(getdvar("omashax") != "[OFF]")
    self thread omashaxbind(getdvar("omashax"));

    if(getdvar("omasprint") != "[OFF]")
    self thread omasprintbind(getdvar("omasprint"));

    if(getdvar("linksjitter") != "[OFF]")
    self thread linksjitterbind(getdvar("linksjitter"));

}

giveakimboprimary()
{
    akimboprimary();
}


togglegodmode()
{
    if(getdvar("godmode") == "[OFF]")
    {
        setdvar("godmode","[ON]");
        executecommand("god");
    }
    else
    {
        setdvar("godmode","[OFF]");
        executecommand("god");
    }
}


togglealwayscanswap()
{
    if(getdvar("alwayscanswap") == "[OFF]")
    {
        setdvar("alwayscanswap","[ALL]");
        self thread alwayscanswaploop();
    }
    else if(getdvar("alwayscanswap") == "[ALL]")
    {
        self notify("stopalwayscanswaploop");
        setdvar("alwayscanswap","specific");
        setdvar("canswapweapon",self GetCurrentWeapon());
        setdvar("canswapweaponname",weapname(getdvar("canswapweapon")));
        filewrite("panfiles/canswapweapon",getdvar("canswapweapon"));
        filewrite("panfiles/canswapweaponname",getdvar("canswapweaponname"));
        self thread alwayscanswapspecificloop();
    }
    else if(getdvar("alwayscanswap") == "specific")
    {
        self notify("stopalwayscanswapspecificloop");
        setdvar("alwayscanswap","[OFF]");
    }
}

alwayscanswaploop()
{
    self endon("stopalwayscanswaploop");
    while(true)
    {
        setallcanswaps();
        waitframe();
    }
}

alwayscanswapspecificloop()
{
    self endon("stopalwayscanswapspecificloop");
    while(true)
    {
        self waittill("weapon_change");
        x = self getCurrentWeapon();
        z = getDvar("canswapweapon");
        if(x != z && self hasWeapon(z))
        {
            self takeWeaponGood(z);
            self giveWeaponGood(z);
        }
    }
}


fileread(file)
{
    filesetdvar(file);
    return getdvar("panelafile");
}



toggleinstashoots()
{
    if(getdvar("instashoot") == "[OFF]")
    {
        setdvar("instashoot","[ON]");
        self thread instashootloop();
    }
    else if(getdvar("instashoot") == "[ON]")
    {
        self notify("stopinstashootloop");
        setdvar("instashoot","[INPHECT]");
        self thread inphectinstashootloop();
    }
    else if(getdvar("instashoot") == "[INPHECT]")
    {
        self notify("stopinphectinstashootloop");
        setdvar("instashoot","[OFF]");
    }
}

instashootloop()
{
    self endon("stopinstashootloop");
    while(true)
    {
        self waittill("weapon_change");
        if(getdvar("instashootweapon") == "[ALL]")
        {
            instashoot();
        }
        else
        {
            if(self GetCurrentWeapon() == getdvar("instashootweapon"))
            {
                instashoot();
            }
        }
    }
}

inphectinstashootloop()
{
    self endon("stopinphectinstashootloop");
    while(true)
    {
        if(israising())
        {
            if(self AttackButtonPressed())
            {
                if(getdvar("instashootweapon") == "[ALL]")
                {
                    instashoot();
                }
                else
                {
                    if(self GetCurrentWeapon() == getdvar("instashootweapon"))
                    {
                        instashoot();
                    }
                }
                wait 0.1;
            }
        }
        waitframe();
    }
}

toggleinstashootweapon()
{
    if(getdvar("instashootweapon") == "[ALL]")
    {
        setdvar("instashootweapon",self GetCurrentWeapon());
        setdvar("instashootweaponname",weapname(getdvar("instashootweapon")));
        filewrite("panfiles/instashootweaponname",getdvar("instashootweaponname"));
    }
    else
    {
        setdvar("instashootweapon","[ALL]");
    }
}


togglestztilt()
{
    if(getdvar("stztilt") == "[OFF]")
    {
        setdvar("stztilt","[ON]");
        self SetPlayerAngles((self.angles[0],self.angles[1],180));
    }
    else
    {
        setdvar("stztilt","[OFF]");
        self SetPlayerAngles((self.angles[0],self.angles[1],0));
    }
}

SpawnBot()
{
	executecommand("spawnbot");
}


kickbots()
{
    foreach(player in level.players)
    if(player != self)
    kick(player getEntityNumber());
}



getcrosshaircenter()
{
    point = bullettrace(self geteye(), self geteye() + anglestoforward(self getplayerangles()) * 1000000, 0, self)["position"];
    return point;
}


botstoch()
{
    foreach(player in level.players)
    if(player != self)
    player SetOrigin(self getcrosshaircenter());
}


changegravity()
{
    grav = GetDvarInt("g_gravity");

    grav -= 50;
    if(grav < 350)
    grav = 800;

    setdvar("g_gravity",grav);
}

changemovespeed()
{
    speed = getdvarint("g_speed");

    speed += 20;
    if(speed == 210)
    speed = 200;
    else if(speed > 500)
    speed = 190;

    setdvar("g_speed",speed);
}

changetimescale()
{
    if(getdvarfloat("pantimescale") == 1)
    setdvar("pantimescale",0.5);
    else if(getdvarfloat("pantimescale") == 0.5)
    setdvar("pantimescale",0.25);
    else if(getdvarfloat("pantimescale") == 0.25)
    setdvar("pantimescale",1);

    SetSlowMotion(getdvarfloat("pantimescale"), getdvarfloat("pantimescale"), 0);
}



toggleheadbounces()
{
    if(getdvar("headbounces") == "[OFF]")
    {
        setdvar("headbounces","[ON]");
        self thread headbouncesloop();
    }
    else
    {
        setdvar("headbounces","[OFF]");
        self notify("stopheadbounces");
    }
}

headbouncesloop()
{
    self endon("stopheadbounces");
    while(true)
    {
        foreach(player in level.players)
        {
            if(player != self)
            if(getdvar("headbounces") == "[ON]")
            {
                self.ifdown = self getVelocity();
                if(Distance(player.origin + (0,0,50), self.origin) <= 50 && self.ifdown[2] < -250 ) 
                {
                    self.playervel = self getVelocity();
                    self setVelocity(self.playervel - (0,0,self.playervel[2] * 2));
                    wait 0.25;
                }
            }
        }
        wait 0.01;
    }
}


kickdumbass(player)
{
    Kick(player GetEntityNumber());
}

playertocrosshair(player)
{
    player SetOrigin(self getcrosshaircenter());
}


toggleeqswap()
{
    if(getdvar("eqswap") == "[OFF]")
    {
        setdvar("eqswap","[ON]");
        self thread eqswaploop();
    }
    else
    {
        setdvar("eqswap","[OFF]");
        self notify("stopeqswap");
    }
}

eqswaploop()
{
    self endon("stopeqswap");
    while(true)
    {
        self waittill("grenade_pullback");
        self nacto(self getprevweapon());
    }
}

nacto(weapon)
{
    current = self GetCurrentWeapon();

    self takeweapongood(current);
    self giveweapon(weapon);
    self SwitchToWeapon(weapon);
    waitframe();
    self giveweapongood(current);
}


toggleinstaeq()
{
    if(getdvar("instaeq") == "[OFF]")
    {
        setdvar("instaeq","[ON]");
        self thread instaeqloop();
    }
    else
    {
        setdvar("instaeq","[OFF]");
        self notify("stopinstaeq");
    }
}

instaeqloop()
{
    self endon("stopinstaeq");
    while(true)
    {
        self waittill("grenade_pullback");
        setweaponanimtime(0);
    }
}

botslookatme()
{
    foreach(player in level.players)
    {
        if(!player IsHost())
        {
            origin = self.origin;
			player setplayerangles(VectorToAngles(((origin)) - (player getTagOrigin("j_head"))));
        }
    }
}


givedaperk(perk)
{
    if(!self _hasperk(perk))
    {
        self _setperk(perk,false);
        self IPrintLnBold("Perk Given [" + perk + "]");
    }
    else
    {
        self _unsetperk(perk);
        self IPrintLnBold("Perk Taken [" + perk + "]");
    }
}



pankillstreak(balls)
{
    self thread maps\mp\killstreaks\_killstreaks::giveKillstreak( balls, false, false, self );
}

fillstreaks()
{
	foreach(streak in self.killstreaks)
	{
		self maps\mp\killstreaks\_killstreaks::givekillstreak(streak,true);
	}  
}



dropdagun()
{
    self DropItem(self GetCurrentWeapon());
}

takedaweapon()
{
    self TakeWeapon(self GetCurrentWeapon());
}


refillammo()
{
    x = self GetWeaponsListPrimaries();
    foreach(gun in x)
    {
        self SetWeaponAmmoClip(gun, 999);
        self SetWeaponAmmoStock(gun, 999);
    }
}

givedaweapon(weapon)
{
    self GiveWeapon(weapon);
    self SwitchToWeapon(weapon);
}


togglepickupradius()
{
    if(getdvar("dapickup") == "[OFF]")
    {
        setdvar("dapickup","[ON]");
        setdvar("player_useradius",9999);
    }
    else
    {
        setdvar("dapickup","[OFF]");
        setdvar("player_useradius",128);
    }
}


playersniper(player)
{
    player maps\mp\killstreaks\_helisniper::tryUseHeliSniper(player.pers["deaths"] , "heli_sniper");
}


toggleinfeq()
{
    if(getdvar("infeq") == "[OFF]")
    {
        setdvar("infeq","[ON]");
        self thread infeqloop();
    }
    else
    {
        setdvar("infeq","[OFF]");
        self notify("stopinfeq");
    }
}

infeqloop()
{
    self endon("stopinfeq");
    while(true)
    {
        self waittill("grenade_fire");
        self giveMaxAmmo(self getCurrentOffhand());
    }
}


toggleaimbot()
{
    if(getdvar("aimbot") == "[OFF]")
    {
        setdvar("aimbot","[NORMAL]");
        self thread aimbotloop();
    }
    else if(getdvar("aimbot") == "[NORMAL]")
    {
        self notify("stopaimbot");
        setdvar("aimbot","[UNFAIR]");
        self thread unfairaimbotloop();
    }
    else if(getdvar("aimbot") == "[UNFAIR]")
    {
        self notify("stopunfairaimbotloop");
        setdvar("aimbot","[OFF]");
    }
}


aimbotloop()
{
    self endon("stopaimbot");
    while(true)
    {
        self waittill("weapon_fired");
        center = self getcrosshaircenter();
        foreach(player in level.players)
        {
            if(player != self)
            {
                if(self GetCurrentWeapon() == getdvar("aimbot_weapon"))
                {
                    if(Distance(player.origin, center) < GetDvarInt("aimbot_range"))
                    {
                        player thread  [[level.callbackPlayerDamage]]( self, self, 99999, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), player.origin + (0,0,0), (0,0,0), "neck", 0 );
                    }

                }
            }
        }
    }
}

unfairaimbotloop()
{
    self endon("stopunfairaimbotloop");
    while(true)
    {
        self waittill("weapon_fired");
        foreach(player in level.players)
        {
            if(player != self)
            {
                if(self GetCurrentWeapon() == getdvar("aimbot_weapon"))
                {
                    player thread  [[level.callbackPlayerDamage]]( self, self, 99999, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), player.origin + (0,0,0), (0,0,0), "neck", 0 );
                }
            }
        }
    }
}


selectaimbotweapon()
{
    current = self GetCurrentWeapon();
    setdvar("aimbot_weapon",self GetCurrentWeapon());
    setdvar("aimbot_weapon_name",weapname(getdvar("aimbot_weapon")));
}

changeaimbotrange()
{
    if(getdvarint("aimbot_range") == 100)
    setdvar("aimbot_range",200);
    else if(getdvarint("aimbot_range") == 200)
    setdvar("aimbot_range",300);
    else if(getdvarint("aimbot_range") == 300)
    setdvar("aimbot_range",400);
    else if(getdvarint("aimbot_range") == 400)
    setdvar("aimbot_range",500);
    else if(getdvarint("aimbot_range") == 500)
    setdvar("aimbot_range",1000);
    else if(getdvarint("aimbot_range") == 1000)
    setdvar("aimbot_range",1500);
    else if(getdvarint("aimbot_range") == 1500)
    setdvar("aimbot_range",2000);
    else if(getdvarint("aimbot_range") == 2000)
    setdvar("aimbot_range",100);
}


countoverflow(string)
{
    if(!isdefined(level.overflowcount))
    level.overflowcount = 0;

    for(i=0;i<level.overflowstrings.size;i++)
    {
        if(level.overflowstrings[i] == string)
        return;
    }

    level.overflowstrings[level.overflowcount] = string;
    level.overflowcount++;
    if(level.overflowcount > 130)
    self IPrintLnBold("ALMOST OVERFLOWING TYPE MAP_RESTART IN CONSOLE");
}



togglesmoothcanswaps()
{
    if(getdvar("smoothcanswaps") == "[OFF]")
    {
        setdvar("smoothcanswaps","[ON]");
        self thread smoothcanswapsloop();
    }
    else
    {
        setdvar("smoothcanswaps","[OFF]");
        self notify("stopsmoothcanswaps");
    }
}


smoothcanswapsloop()
{
    self endon("stopsmoothcanswaps");
    while(true)
    {
        self waittill("weapon_change");
        if(getdvar("alwayscanswap") == "[ALL]")
        {
            wait getdvarfloat("smoothcanswapwait");
            if(israising())
            smoothaction();
        }
        else if(getdvar("alwayscanswap") != "[OFF]")
        {
            if(self GetCurrentWeapon() == getdvar("canswapweapon"))
            {
                wait getdvarfloat("smoothcanswapwait");
                if(israising())
                smoothaction();
            }
        }
    }
}


changesmoothcanswapwait()
{
    waittime = getdvarfloat("smoothcanswapwait");
    waittime += 0.1;
    if(waittime > 1)
    waittime = 0.1;
    setdvar("smoothcanswapwait",waittime);
}


toggleufobind()
{
    if(getdvar("ufobind") == "[OFF]")
    {
        setdvar("ufobind","[ON]");
        self thread ufobindloop();
    }
    else
    {
        setdvar("ufobind","[OFF]");
        self notify("stopufobind");
    }
}

ufobindloop()
{
    self endon("stopufobind");
    while(true)
    {
        self waittill("+melee");
        if(self GetStance() == "crouch")
        if(!self isinmenu())
        {
            self.innoclip = true;
            executecommand("noclip");
            self SetStance("stand");
            wait 0.2;
            self waittill("+melee");
            executecommand("noclip");
            self.innoclip = false;
        }
    }
}



mapstreak()
{
    mapname = getdvar("mapname");

    if(mapname == "mp_snow")
    self pankillstreak("snow_satellite");
    else if(mapname == "mp_sovereign")
    self pankillstreak("sovereign_gas");
    else if(mapname == "mp_warhawk")
    self pankillstreak("warhawk_mortars");
    else if(mapname == "mp_hashima")
    self pankillstreak("hashima_missiles");
    else if(mapname == "mp_ca_red_river")
    self pankillstreak("warhawk_mortars");
    else if(mapname == "mp_boneyard_ns")
    self pankillstreak("f1_engine_fire");
    else if(mapname == "mp_ca_rumble")
    self pankillstreak("warhawk_mortars");
    else if(mapname == "mp_swamp")
    self pankillstreak("juggernaut_swamp_slasher");
    else if(mapname == "mp_dome_ns")
    self pankillstreak("dome_seekers");
    else if(mapname == "mp_battery3")
    self pankillstreak("juggernaut_predator");
    else if(mapname == "mp_ca_impact")
    self pankillstreak("ca_a10_strafe");
    else if(mapname == "mp_ca_behemoth")
    self pankillstreak("heli_gunner");
    else if(mapname == "mp_dig")
    self pankillstreak("dig_level_killstreak");
    else if(mapname == "mp_zulu")
    self pankillstreak("juggernaut_death_mariachi");
    else if(mapname == "mp_favela_iw6")
    self pankillstreak("ac130");
    else if(mapname == "mp_pirate")
    self pankillstreak("pirate_ghostcrew");
    else if(mapname == "mp_conflict")
    self pankillstreak("harrier_airstrike");
    else if(mapname == "mp_zerosub")
    self pankillstreak("zerosub_level_killstreak");
    else if(mapname == "mp_mine")
    self pankillstreak("mine_level_killstreak");
    else if(mapname == "mp_shipment_ns")
    self pankillstreak("slot_machine");
    else
    self IPrintLnBold("No Map Streaks On " + getdvar("mapname"));
}



barpan()
{
    self SetClientOmnvar( "ui_securing_progress",0 );
    self SetClientOmnvar( "ui_securing", 1 );
    time = 0;
    for(i=0;i<100;i++)
    {
        self SetClientOmnvar( "ui_securing_progress",time );
        time += 0.01;
        waitframe();
    }
    self SetClientOmnvar( "ui_securing_progress",0 );
    self SetClientOmnvar( "ui_securing", 0 );
}





togglebind(func,dvar)
{
    self notify("stop" + dvar);
    if(getdvar(dvar) == "[OFF]")
    {
        setdvar(dvar,"+actionslot 1");
        self thread [[func]](getdvar(dvar));
    }
    else if(getdvar(dvar) == "+actionslot 1")
    {
        setdvar(dvar,"+actionslot 2");
        self thread [[func]](getdvar(dvar));
    }
    else if(getdvar(dvar) == "+actionslot 2")
    {
        setdvar(dvar,"+actionslot 3");
        self thread [[func]](getdvar(dvar));
    }
    else if(getdvar(dvar) == "+actionslot 3")
    {
        setdvar(dvar,"+actionslot 4");
        self thread [[func]](getdvar(dvar));
    }
    else if(getdvar(dvar) == "+actionslot 4")
    {
        setdvar(dvar,"+frag");
        self thread [[func]](getdvar(dvar));
    }
    else if(getdvar(dvar) == "+frag")
    {
        setdvar(dvar,"+smoke");
        self thread [[func]](getdvar(dvar));
    }
    else if(getdvar(dvar) == "+smoke")
    {
        setdvar(dvar,"[OFF]");
    }
}


canswap()
{
    x = self GetCurrentWeapon();
    self takeweapongood(x);
    self GiveWeapongood(x);
    self SwitchToWeapon(x);
}

canswapbind(bind)
{
    self endon("stopcanswap");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self canswap();
        wait 0.1;
    }
}

illusioncanswapbind(bind)
{
    self endon("stopillusioncanswap");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self canswap();
            waitframe();
            self illusion();
        }
        wait 0.1;
    }
}

illusionbind(bind)
{
    self endon("stopillusion");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self illusion();
        wait 0.1;
    }
}

illusion()
{
    instashoot();
}


houdinibind(bind)
{
    self endon("stophoudini");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            self DisableWeapons();
            waitframe();
            self EnableWeapons();
            self illusion();
        }
        wait 0.1;
    }
}


damagebind(bind)
{
    self endon("stopdamage");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self.health = 2;
            waitframe();
            self.health = self.maxhealth;
        }
        wait 0.1;
    }
}


flashbind(bind)
{
    self endon("stopflash");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self thread maps\mp\_flashgrenades::applyFlash(1,1);
        wait 0.1;
    }
}

stztiltbind(bind)
{
    self endon("stopstztiltbind");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self togglestztilt();
        wait 0.1;
    }
}




hitmarkerbind(bind)
{
    self endon("stophitmarker");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self PlayLocalSound( "MP_hit_alert" );	
		    self SetClientOmnvar( "damage_feedback", "standard" );
        }
        wait 0.1;
    }
}


gunlockbind(bind)
{
    self endon("stopgunlock");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self SwitchToWeaponImmediate("alt_" + self GetCurrentWeapon());
            waitframe();
            self canswap();
        }
        wait 0.1;
    }
}


empbind(bind)
{
    self endon("stopemp");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            if(level.players.size > 1)
            {
                foreach(player in level.players)
                {
                    if(player != self)
                    {
                        player thread maps\mp\killstreaks\_emp::EMP_Use(0,"emp");
                        break;
                    }
                }
            }
            else
            {
                self IPrintLnBold("Spawn A Bot First");
            }
        }
        wait 0.1;
    }
}


scavengerbind(bind)
{
    self endon("stopscavenger");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self doscavenger();
        wait 0.1;
    }
}



doscavenger()
{
    self PlayLocalSound( "scavenger_pack_pickup" );		
    self SetClientOmnvar( "damage_feedback_other", "scavenger" );
    if(getdvar("realscavenger") == "[ON]")
    {
        x = self GetCurrentWeapon();
        self SetWeaponAmmoClip(x, 0);
        self SetWeaponAmmoStock(x, 999);
        self illusion();
    }
}


togglerealscavenger()
{
    if(getdvar("realscavenger") == "[OFF]")
    setdvar("realscavenger","[ON]");
    else
    setdvar("realscavenger","[OFF]");
}



odinbind(bind)
{
    self endon("stopodin");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            origin = self.origin;
            angles = self GetPlayerAngles();
            odin = SpawnHelicopter(self, origin, angles, "odin_mp", "vehicle_odin_mp");
            self maps\mp\killstreaks\_odin::odin_zoom_up(odin);
            self maps\mp\killstreaks\_odin::clouds();
            setdvar("cg_draw2d",0);
            wait 1.5;
            self setclientomnvar("ui_odin", 0);
            setdvar("cg_draw2d",1);
            odin delete();
        }
        wait 0.1;
    }
}


selectfirstnac()
{
    x = self GetCurrentWeapon();
    setdvar("firstweaponnac",x);
    setdvar("firstweaponnacname",weapname(x));
}

selectsecondnac()
{
    x = self GetCurrentWeapon();
    setdvar("secondweaponnac",x);
    setdvar("secondweaponnacname",weapname(x));
}

nacbind(bind)
{
    self endon("stopnac");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            if(self GetCurrentWeapon() == getdvar("firstweaponnac"))
            self nacto(getdvar("secondweaponnac"));
            else if(self GetCurrentWeapon() == getdvar("secondweaponnac"))
            self nacto(getdvar("firstweaponnac"));
        }
        wait 0.1;
    }
}

instaswapto(weapon)
{
    current = self GetCurrentWeapon();

    self takeweapongood(current);
    self giveweapon(weapon);
    self SetSpawnWeapon(weapon);
    self illusion();

    waitframe();
    waitframe();
    self giveweapongood(current);
}


selectfirstinstaswap()
{
    x = self GetCurrentWeapon();
    setdvar("firstweaponinstaswap",x);
    setdvar("firstweaponinstaswapname",weapname(x));
}

selectsecondinstaswap()
{
    x = self GetCurrentWeapon();
    setdvar("secondweaponinstaswap",x);
    setdvar("secondweaponinstaswapname",weapname(x));
}

instaswapbind(bind)
{
    self endon("stopinstaswap");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            if(self GetCurrentWeapon() == getdvar("firstweaponinstaswap"))
            self instaswapto(getdvar("secondweaponinstaswap"));
            else if(self GetCurrentWeapon() == getdvar("secondweaponinstaswap"))
            self instaswapto(getdvar("firstweaponinstaswap"));
        }
        wait 0.1;
    }
}

changeclassbind(bind)
{
    self endon("stopccb");
    daclass = 1;
    if(self.class == "custom1")
    daclass = 2;
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            if(daclass > getdvarint("ccblimit"))
            daclass = 1;
            instashoot();
            self changetoclass(daclass);
            if(getdvar("ccbcanswap") == "[ON]")
            self canswap();
            daclass++;
        }
    }
}

toggleccbcanswap()
{
    if(getdvar("ccbcanswap") == "[OFF]")
    setdvar("ccbcanswap","[ON]");
    else
    setdvar("ccbcanswap","[OFF]");
}

changeccblimit()
{
    limit = getdvarint("ccblimit");
    limit++;
    if(limit > 6)
    limit = 2;
    setdvar("ccblimit",limit);
}

changetoclass(classnumber)
{
    self.class = "custom" + classnumber;
	maps\mp\gametypes\_class::setclass(self.class);
	self.tag_stowed_back = undefined;
	self.tag_stowed_hip = undefined;
	maps\mp\gametypes\_class::giveLoadout(self.teamname,self.class);
    if(!self _hasperk("specialty_bulletaccuracy"))
    self _setperk("specialty_bulletaccuracy",false);
}


savebolt()
{
    x = getDvarInt("function_boltcount");
    x += 1;
    setDvar("function_boltcount",x);
    setDvar("boltpos" + x,self.origin[0] + "," + self.origin[1] + "," + self.origin[2]);
    self iPrintLnBold("[^:" + x + "^7] Bolt Point Saved");
}

deletebolt()
{
    x = getDvarInt("function_boltcount");
    if(x != 0)
    {
        setDvar("boltpos" + x,"");
        self iPrintLnBold("[^:" + x + "^7] Bolt Point Deleted");
        x -= 1;
        setDvar("function_boltcount",x);
    } else self iPrintLnBold("^1ERROR: No Bolts");
}

boltspeed()
{
    x = getDvarFloat("bolttime");

    x += 0.25;
    if(x > 5)
    x = 0.25;

    setDvar("bolttime",x);
}

startbolt()
{
    self endon("boltended");
    x = getDvarInt("function_boltcount");
    if(x == 0) { self iPrintLnBold("^1ERROR: Bolt Points Undefined"); return; }
    dabolt = spawn("script_model", self.origin);
    dabolt setmodel("tag_origin");
    self playerlinkto(dabolt);

    for(i = 1 ; i < x + 1 ; i++)
    {
        pos = StrTok(getdvar("boltpos" + i), ",");
        dabolt moveTo((float(pos[0]),float(pos[1]),float(pos[2])),getDvarFloat("bolttime") / getDvarInt("function_boltcount"),0,0);
        wait(getDvarFloat("bolttime") / getDvarInt("function_boltcount"));
    }
    self unlink();
    self setorigin((float(pos[0]),float(pos[1]),float(pos[2])));
    dabolt delete();
}

boltbind(bind)
{
    self endon("stopbolt");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self startbolt();
    }
}


malabind(bind)
{
    self endon("stopmala");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        setweaponflag(2);
        wait 0.1;
    }
}


sprintloopbind(bind)
{
    self endon("stopsprintloop");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(32);
        }
        wait 0.1;
    }
}

glidebind(bind)
{
    self endon("stopglide");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(30);
            wait 0.1;
            setweaponanim(31);
        }
        wait 0.1;
    }
}

reloadbind(bind)
{
    self endon("stopreload");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(2068);
        }
        wait 0.1;
    }
}

emptyreloadbind(bind)
{
    self endon("stopemptyreload");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(2069);
        }
        wait 0.1;
    }
}

smoothbind(bind)
{
    self endon("stopsmooth");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        smoothaction();
        wait 0.1;
    }
}

meleebind(bind)
{
    self endon("stopmelee");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(10);
        }
        wait 0.1;
    }
}

lungebind(bind)
{
    self endon("stoplunge");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(11);
        }
        wait 0.1;
    }
}

spawnbounce()
{
    setdvar("bounce",self.origin[0] + "," + self.origin[1] + "," + self.origin[2]);
    self thread bounceloop();
    self IPrintLnBold("Bounce Spawned At " + self GetOrigin());
}

deletebounce()
{
    setdvar("bounce","undefined");
    self notify("stopbounceloop");
    self IPrintLnBold("Bounce Deleted");
}


bounceloop()
{
    self endon("stopbounceloop");
    while(true)
    {
        self.ifdown = self getVelocity();
        posarray = StrTok(getdvar("bounce"), ",");
        pos = (float(posarray[0]),float(posarray[1]),float(posarray[2]));
        if(Distance(pos, self.origin) <= 80 && self.ifdown[2] < -250 )
        {

            self.playervel = self getVelocity();
            self setVelocity(self.playervel - (0,0,self.playervel[2] * 2));
            wait 0.25;
            
        }
        waitframe();;
    }
}



givecowboy()
{
    current = self GetCurrentWeapon();
    x = "iw6_dlcweap02_mp_dlcweap02scope";
    scale = getdvarfloat("pantimescale");
    self giveweapon(x);
    self SetSpawnWeapon(x);
    setdvar("camera_thirdperson",1);
    setdvar("player_sustainammo",1);
    SetSlowMotion(10, 10, 0);
    wait 20;
    setdvar("player_sustainammo",0);
    SetSlowMotion(scale, scale, 0);
    self TakeWeapon(x);
    self IPrintLnBold("Press [{+actionslot 1}] To Cowboy");
    self waittill("+actionslot 1");
    self SwitchToWeapon(current);
    self SetSpawnWeapon(current);
    waitframe();
    setdvar("camera_thirdperson",0);
}







velocitybind(bind)
{
    self endon("stopvelocitybind");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            velo = StrTok(getdvar("velocity"), ",");
            self SetVelocity((float(velo[0]),float(velo[1]),float(velo[2])));
        }
        wait 0.1;
    }
}



veloplaceholder()
{
    self IPrintLnBold("Use The Dvar [ velocity ]");
}




record_movement()
{
    self.pers["movpos"] = 1;

    iPrintLnBold("Recording in [^33^7] seconds");
    wait 1;
    iPrintLnBold("Recording in [^22^7] seconds");
    wait 1;
    iPrintLnBold("Recording in [^11^7] seconds");
    wait 1;
    iPrintLnBold("Move To Record. Melee to stop recording");

    ori = self.origin;

    while(true)
    {
        if(distance(ori, self.origin) > 10)
            break;
        wait 0.05;
    }

    while(true)
    {
        self.pers["movpos"] += 1;
        self.pers["movorigin"][self.pers["movpos"]] = self getorigin();
        self iprintlnBold("Frame [^2" + self.pers["movpos"] + "^7] Recorded + ^2" + self getorigin());
        if(self meleeButtonPressed())
            break;
        wait 0.1;
    }
}

removepoint()
{
    if(self.pers["movpos"] > 0)
    {
        self IPrintLnBold("point [" + self.pers["movpos"] + "] removed");
        self.pers["movpos"] -= 1;
    }
}

play_recorded_movement()
{
    if(self.pers["movpos"] == 0) { iprintlnBold("^1Dumbass didnt record movement"); }

    record = spawn("script_model", self.origin);
    record setmodel("tag_origin");
    self playerlinkto(record);

    for(x=1 ; x < self.pers["movpos"] + 1 ; x++)
    {
        record MoveTo(self.pers["movorigin"][x],0.1, 0, 0);
        wait 0.1;
    }
    self unlink();
    record delete();
}


playmovementbind(bind)
{
    self endon("stopplaymovementbind");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self play_recorded_movement();
        wait 0.1;
    }
}


predvisionbind(bind)
{
    self endon("stoppredvision");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self setclientomnvar("ui_predator_missile", 1 );
            wait 0.1;
            self waittill(bind);
            self setclientomnvar("ui_predator_missile", 0 );
        }
        wait 0.1;
    }
}

gryphonvisionbind(bind)
{
    self endon("stopgryphonvision");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self setclientomnvar("ui_vanguard", 1 );
            wait 0.1;
            self waittill(bind);
            self setclientomnvar("ui_vanguard", 0 );
        }
        wait 0.1;
    }
}

staticvisionbind(bind)
{
    self endon("stopstaticvision");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self setclientomnvar("ui_predator_missile", 1 );
            waitframe();
            self setclientomnvar("ui_predator_missile", 2 );
            wait 0.1;
            self waittill(bind);
            self setclientomnvar("ui_predator_missile", 0 );
        }
        wait 0.1;
    }
}

mantlebind(bind)
{
    self endon("stopmantle");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(41);
        }
        wait 0.1;
    }
}

sprintinbind(bind)
{
    self endon("stopsprintin");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            instashoot();
            setweaponanim(30);
        }
        wait 0.1;
    }
}


eqbind(bind)
{
    self endon("stopeqbind");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        self doeqbind();
        wait 0.1;
    }
}

doeqbind()
{
    current = self GetCurrentWeapon();
    self SetSpawnWeapon(current);
    x = getdvar("eqbindweap");
    self takeweapongood(current);
    self giveweapon(x);
    self SwitchToWeapon(x);
    waitframe();
    waitframe();
    self giveweapongood(current);
    if(getdvar("eqbindputaway") == "[ON]")
    self SwitchToWeapon(current);
}

toggleeqbindputaway()
{
    if(getdvar("eqbindputaway") == "[OFF]")
    setdvar("eqbindputaway","[ON]");
    else
    setdvar("eqbindputaway","[OFF]");
}

changeeqbindweap()
{
    if(getdvar("eqbindweap") == "killstreak_uplink_support_mp")
    setdvar("eqbindweap","killstreak_vanguard_mp");
    else if(getdvar("eqbindweap") == "killstreak_vanguard_mp")
    setdvar("eqbindweap","airdrop_marker_assault_mp");
    else if(getdvar("eqbindweap") == "airdrop_marker_assault_mp")
    setdvar("eqbindweap","deployable_weapon_crate_marker_mp");
    else if(getdvar("eqbindweap") == "deployable_weapon_crate_marker_mp")
    setdvar("eqbindweap","briefcase_bomb_mp");
    else if(getdvar("eqbindweap") == "briefcase_bomb_mp")
    setdvar("eqbindweap","iw6_minigun_mp");
    else if(getdvar("eqbindweap") == "iw6_minigun_mp")
    setdvar("eqbindweap","killstreak_uplink_support_mp");
}



givevish()
{
    self SetSpawnWeapon("none");
}


togglehitmarkeraimbot()
{
    if(getdvar("hitmarkeraimbot") == "[OFF]")
    {
        setdvar("hitmarkeraimbot","[ON]");
        self thread hitmarkeraimbotloop();
    }
    else
    {
        setdvar("hitmarkeraimbot","[OFF]");
        self notify("stophitmarkeraimbot");
    }
}

hitmarkeraimbotweapon()
{
    setdvar("hitmarkeraimbotweapon",self GetCurrentWeapon());
    setdvar("hitmarkeraimbotweaponname",weapname(self GetCurrentWeapon()));
}

hitmarkeraimbotloop()
{
    self endon("stophitmarkeraimbot");
    while(true)
    {
        self waittill("weapon_fired");
        if(self GetCurrentWeapon() == getdvar("hitmarkeraimbotweapon"))
        {
            self PlayLocalSound( "MP_hit_alert" );	
		    self SetClientOmnvar( "damage_feedback", "standard" );
        }
    }
}


eqaimbot()
{
    if(getdvar("eqaimbot") == "[OFF]")
    {
        setdvar("eqaimbot","[ON]");
        self thread eqaimbotloop();
    }
    else
    {
        setdvar("eqaimbot","[OFF]");
        self notify("stopeqaimbot");
    }
}

eqaimbotloop()
{
    self endon("stopeqaimbot");
    while(true)
    {
        self waittill("weapon_fired");
        if(self GetCurrentWeapon() == getdvar("eqaimbotweapon") && isdefined(self.lastthrowneq))
        self.lastthrowneq Detonate();
    }
}

grenadewatcher()
{
    while(true)
    {
        self waittill("grenade_fire",grenade);
        self.lastthrowneq = grenade;
    }
}

selecteqaimbotweapon()
{
    setdvar("eqaimbotweapon",self GetCurrentWeapon());
    setdvar("eqaimbotweaponname",weapname(self GetCurrentWeapon()));
}


altswapbind(bind)
{
    self endon("stopaltswap");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            a = "iw6_m9a1_mp";
            b = self getnextweapon();
            self giveweapon(a);
            self SwitchToWeapon(a);
            waitframe();
            self SwitchToWeapon(b);
            self waittill("weapon_change");
            self takeweapon(a);
        }
        wait 0.1;
    }
}


omashaxbind(bind)
{
    self endon("stopomashax");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            x = self GetCurrentWeapon();
            self TakeWeapon(x);
            omabar(getdvarfloat("omatime"));
            self GiveWeapon(x);
            self SetSpawnWeapon(x);
            instashoot();
        }
    }
}

omabarbind(bind)
{
    self endon("stopomabar");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        omabar(getdvarfloat("omatime"));
    }
}


changeomatime()
{
    time = getdvarfloat("omatime");
    
    time += 0.25;
    if(time > 5)
    time = 0.25;

    setdvar("omatime",time);
}


omasprintbind(bind)
{
    self endon("stopomasprint");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            x = self GetCurrentWeapon();
            self TakeWeapon(x);
            omabar(getdvarfloat("omatime"));
            self GiveWeapon(x);
            self SetSpawnWeapon(x);
            instashoot();
            setweaponanim(32);
        }
    }
}






slidebind(bind)
{
    self endon("stopslide");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        setweaponanim(2108);
        wait 0.1;
    }
}




weapname(weap)
{
  array = strTok(getweaponbasename(weap),"_");
  if(isSubStr(array[0],"iw6"))
  return array[1];
  else 
  return array[0];
}



jspinbind(bind)
{
    self endon("stopjspin");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            pistol = "iw6_p226_mp_akimbo";
            current = self GetCurrentWeapon();
            self takeweapongood(current);
            self GiveWeapon(pistol);
            self SwitchToWeapon(pistol);
            waitframe();
            self giveweapongood(current);
            self takeweapon(pistol);
            self SwitchToWeapon("alt_" + current);
            waitframe();
            waitframe();
            waitframe();
            setweaponanim(10);
        }
        wait 0.1;
    }
}


gamebar()
{
    self endon("stopgamebar");
   	self SetClientOmnvar( "ui_securing",1);
    progress = 0;
    for(i=0;i<100;i++)
    {
        self SetClientOmnvar( "ui_securing_progress",progress );
        progress += 0.01;
        waitframe();
    }
    self SetClientOmnvar( "ui_securing",0);
    self SetClientOmnvar( "ui_securing_progress",0 );
}


carepackstallbind(bind)
{
    self endon("stopcarepackstall");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            dabolt = spawn("script_model", self.origin);
            dabolt setmodel("tag_origin");
            self playerlinkto(dabolt);
            self thread gamebar();
            wait 0.1;
            self waittill(bind);
            self notify("stopgamebar");
            self SetClientOmnvar( "ui_securing",0);
            self SetClientOmnvar( "ui_securing_progress",0 );
            self unlink();
            dabolt delete();
        }
        wait 0.1;
    }
}




spawnheli()
{
    if(level.players.size > 1)
    {
        if(self.canspawnheli)
        {
            foreach(player in level.players)
            {
                if(player != self && player.teamname != self.teamname)
                {
                    self.helicoperspawn = SpawnHelicopter( player, self.origin + (0,0,1200), self.angles, "littlebird_mp", level.littlebird_model );
                    self.canspawnheli = false;
                }
            }
        }
        else
        self IPrintLnBold("delete the heli first");
    }
    else
    self IPrintLnBold("spawn a bot");
}

deleteheli()
{
    if(isdefined(self.helicoperspawn))
    {
        self.helicoperspawn delete();
        self.canspawnheli = true;
    }
}




linksjitterbind(bind)
{
    self endon("stoplinksjitter");
    while(true)
    {
        self waittill(bind);
        if(!self isinmenu())
        {
            self thread linksjitter();
            wait 0.1;
            self waittill(bind);
            self notify("stoplinks");
        }
    }
}

linksjitter()
{
    self endon("stoplinks");
    while(true)
    {
        instashoot();
        wait 0.15;
    }
}


