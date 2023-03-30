#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include scripts\utils;
#include scripts\menu;
#include scripts\functions;




init()
{
    setdvar("panelaint",0);
    level.overflowstrings = [];
    level thread OnPlayerConnect();
    setdvar("panelafile","hello");
    setdvar("sv_cheats",1);
    setdvar("pm_bouncing",1);
    setdvar("jump_enablefalldamage", 0);
    level.panperks = StrTok("specialty_fastsprintrecovery,specialty_fastreload,specialty_lightweight,specialty_marathon,specialty_pitcher,specialty_sprintreload,specialty_quickswap,specialty_bulletaccuracy,specialty_quickdraw,specialty_silentkill,specialty_blindeye,specialty_quieter,specialty_incog,specialty_gpsjammer,specialty_paint,specialty_scavenger,specialty_detectexplosive,specialty_selectivehearing,specialty_comexp,specialty_falldamage,specialty_regenfaster,specialty_sharp_focus,specialty_stun_resistance,specialty_explosivedamage,", ",");
    level.panassaultks = StrTok("IMS,Guard Dog,Sentry Gun,Trinity Rocket,Gryphon,Maniac,Juggernaut,Helo Pilot,Loki,", ",");
    level.panassaultks2 = StrTok("ims,guard_dog,sentry,drone_hive,vanguard,airdrop_juggernaut_maniac,airdrop_juggernaut,heli_pilot,odin_assault,", ",");
    level.pansupportks = StrTok("SATCOM,Ammo Crate Gun,Vests,MAAWS,Night Owl,Helo Scout,Ground Jammer,Oracle,Odin,", ",");
    level.pansupportks2 = StrTok("uplink_support,deployable_ammo,deployable_vest,aa_launcher,ball_drone_radar,heli_sniper,jammer,uav_3dping,odin_support,", ",");
}

OnPlayerConnect()
{
    while(true)
    {
        level waittill("connected",player);
        player thread OnPlayerSpawned();
    }
}

OnPlayerSpawned()
{
    while(true)
    {
        self waittill("spawned_player");
        if(self ishost())
        {
            //self givePerkOffhand( "throwingknife_mp", false );
            self thread notifyloop();
            self MonitorButtons();
            self setdvars();
            self thread functionscall();
            self menuinit();
            self thread alwaysclasschange();
            self thread savepos();
            self thread loadpos();
            self thread savefileloop();
            self FreezeControls(false);
            self thread bindtest();
            self thread bindtest2();
            self thread bindtest3();
            self thread kcweaploop();
            self thread grenadewatcher();
            self _setperk("specialty_bulletaccuracy",false);
        }

        while(!self ishost())
        {
            self FreezeControls(true);
            waitframe();
        }
    }
}

kcweaploop()
{
    while(true)
    {
        self setclientomnvar("ui_killcam_killedby_weapon",-1);
        self setclientomnvar("ui_killcam_killedby_attachment1",-1);
        self setclientomnvar("ui_killcam_killedby_attachment2",-1);
        self setclientomnvar("ui_killcam_killedby_attachment3",-1);
        self setclientomnvar("ui_killcam_killedby_attachment4",-1);
        self setclientomnvar("ui_killcam_killedby_abilities1",0);
        self setclientomnvar("ui_killcam_killedby_abilities2",0);
        
        waitframe();
    }
}

bindtest3()
{
    while(true)
    {
        self waittill("+actionslot 4");
    }
}

bindtest2()
{
    while(true)
    {
        self waittill("+frag");
    }
}

//-1123.35,-3545.68,732.936;
//-756.742,-3474.62,700.942;

//2071
bindtest()
{
    while(true)
    {
        self waittill("+smoke");
        
    }
}







/*
instashoot();
setweaponanimright(2068);
setweaponanimleft(30);
wait 0.3;
setweaponanimright(1);
setweaponanimleft(31);
wait 0.5;
self instaswapto(self getnextweapon());
*/


//self waittill("grenade_pullback");
//setweaponanim(25);

//self givePerkEquipment( loadoutEquipment, true );
//self givePerkOffhand( loadoutOffhand, false );

alwaysclasschange()
{  
    game["strings"]["change_class"] = "";
    while(true)
    {
        self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "class_select")
		{
			continue;
		}
        var_01 = var_01 + 1;
        self.class = "custom" + var_01;
		maps\mp\gametypes\_class::setclass(self.class);
		self.tag_stowed_back = undefined;
		self.tag_stowed_hip = undefined;
		maps\mp\gametypes\_class::giveLoadout(self.teamname,self.class);
        if(!self _hasperk("specialty_bulletaccuracy"))
        self _setperk("specialty_bulletaccuracy",false);
        //self givePerkOffhand( "throwingknife_mp", false );
    }
}







israising()
{
    if(israisingpan() == 1)
    return true;
    
    return false;
}

setdvars()
{
    self.canspawnheli = true;
    self.innoclip = false;
    self.pers["movpos"] = 0;
    SetDvarIfUni("linksjitter","[OFF]");
    SetDvarIfUni("godmode","[OFF]");
    SetDvarIfUni("alwayscanswap","[OFF]");
    SetDvarIfUni("instashoot","[OFF]");
    SetDvarIfUni("instashootweapon","[ALL]");
    SetDvarIfUni("savepos",self.origin[0] + "," + self.origin[1] + "," + self.origin[2] + "," + getdvar("mapname"));
    SetDvarIfUni("saveangles",self.angles[0] + "," + self.angles[1] + "," + self.angles[2]);
    SetDvarIfUni("stztilt","[OFF]");
    SetDvarIfUni("g_gravity",800);
    SetDvarIfUni("g_speed",190);
    SetDvarIfUni("pantimescale",1);
    SetDvarIfUni("headbounces","[OFF]");
    SetDvarIfUni("eqswap","[OFF]");
    SetDvarIfUni("instaeq","[OFF]");
    SetDvarIfUni("dapickup","[OFF]");
    SetDvarIfUni("infeq","[OFF]");
    SetDvarIfUni("aimbot","[OFF]");
    SetDvarIfUni("aimbot_weapon","[UNDEFINED]");
    SetDvarIfUni("aimbot_weapon_name","[UNDEFINED]");
    SetDvarIfUni("aimbot_range",100);
    SetDvarIfUni("smoothcanswaps","[OFF]");
    SetDvarIfUni("smoothcanswapwait",0.1);
    SetDvarIfUni("ufobind","[ON]");
    SetDvarIfUni("canswap","[OFF]");
    SetDvarIfUni("illusioncanswap","[OFF]");
    SetDvarIfUni("illusion","[OFF]");
    SetDvarIfUni("houdini","[OFF]");
    SetDvarIfUni("damage","[OFF]");
    SetDvarIfUni("flash","[OFF]");
    SetDvarIfUni("stztiltbind","[OFF]");
    SetDvarIfUni("hitmarker","[OFF]");
    SetDvarIfUni("gunlock","[OFF]");
    SetDvarIfUni("emp","[OFF]");
    SetDvarIfUni("realscavenger","[OFF]");
    SetDvarIfUni("scavenger","[OFF]");
    SetDvarIfUni("odin","[OFF]");
    SetDvarIfUni("nac","[OFF]");
    SetDvarIfUni("firstweaponnac","[UNDEFINED]");
    SetDvarIfUni("firstweaponnacname","[UNDEFINED]");
    SetDvarIfUni("secondweaponnac","[UNDEFINED]");
    SetDvarIfUni("secondweaponnacname","[UNDEFINED]");
    SetDvarIfUni("instaswap","[OFF]");
    SetDvarIfUni("firstweaponinstaswap","[UNDEFINED]");
    SetDvarIfUni("firstweaponinstaswapname","[UNDEFINED]");
    SetDvarIfUni("secondweaponinstaswap","[UNDEFINED]");
    SetDvarIfUni("secondweaponinstaswapname","[UNDEFINED]");
    SetDvarIfUni("ccblimit",2);
    SetDvarIfUni("ccb","[OFF]");
    SetDvarIfUni("ccbcanswap","[OFF]");
    SetDvarIfUni("bolttime",0.25);
    setDvarIfUni("function_boltcount",0);
    SetDvarIfUni("bolt","[OFF]");
    SetDvarIfUni("mala","[OFF]");
    SetDvarIfUni("sprintin","[OFF]");
    SetDvarIfUni("sprintloop","[OFF]");
    SetDvarIfUni("glide","[OFF]");
    SetDvarIfUni("emptyreload","[OFF]");
    SetDvarIfUni("reload","[OFF]");
    SetDvarIfUni("smooth","[OFF]");
    SetDvarIfUni("melee","[OFF]");
    SetDvarIfUni("lunge","[OFF]");
    SetDvarIfUni("velocity","0,0,0");
    SetDvarIfUni("bounce","undefined");
    SetDvarIfUni("velocitybind","[OFF]");
    SetDvarIfUni("playmovementbind","[OFF]");
    SetDvarIfUni("predvision","[OFF]");
    SetDvarIfUni("gryphonvision","[OFF]");
    SetDvarIfUni("staticvision","[OFF]");
    SetDvarIfUni("mantle","[OFF]");
    SetDvarIfUni("eqbind","[OFF]");
    SetDvarIfUni("eqbindputaway","[OFF]");
    SetDvarIfUni("eqbindweap","killstreak_uplink_support_mp");
    SetDvarIfUni("hitmarkeraimbot","[OFF]");
    SetDvarIfUni("hitmarkeraimbotweapon","[undefined]");
    SetDvarIfUni("hitmarkeraimbotweaponname","[undefined]");
    SetDvarIfUni("eqaimbot","[OFF]");
    SetDvarIfUni("eqaimbotweapon","[undefined]");
    SetDvarIfUni("eqaimbotweaponname","[undefined]");
    SetDvarIfUni("altswap","[OFF]");
    SetDvarIfUni("omashax","[OFF]");
    SetDvarIfUni("omabar","[OFF]");
    SetDvarIfUni("omasprint","[OFF]");
    SetDvarIfUni("omatime",0.25);
    SetDvarIfUni("slide","[OFF]");
    SetDvarIfUni("jspin","[OFF]");
    SetDvarIfUni("carepackstall","[OFF]");

    if(getdvarint("function_boltcount") != 0)
    {
        for(i=1;i<getdvarint("function_boltcount");i++)
        {
            setDvarIfUni("boltpos" + i,0);
        }
    }
}


savepos()
{
    while(true)
    {
        self waittill("+actionslot 3");
        if(self GetStance() == "crouch")
        {
            self IPrintLnBold("Position Saved " + self GetOrigin());
            setdvar("savepos",self.origin[0] + "," + self.origin[1] + "," + self.origin[2] + "," + getdvar("mapname"));
            setdvar("saveangles",self.angles[0] + "," + self.angles[1] + "," + self.angles[2]);
            filewrite("panfiles/saveangles",self.angles[0] + "," + self.angles[1] + "," + self.angles[2]);
            filewrite("panfiles/savepos",self.origin[0] + "," + self.origin[1] + "," + self.origin[2] + "," + getdvar("mapname"));
            wait 0.2;
        }
    }
}

loadpos()
{
    while(true)
    {
        self waittill("+actionslot 2");
        if(self GetStance() == "crouch")
        {
            array = StrTok(getdvar("savepos"), ",");
            array2 = StrTok(getdvar("saveangles"), ",");
            if(getdvar("mapname") == array[3])
            {
                self SetOrigin((float(array[0]),float(array[1]),float(array[2])));
                self SetPlayerAngles((0,float(array2[1]),float(array2[2])));
            }
            wait 0.2;
        }
    }
}
