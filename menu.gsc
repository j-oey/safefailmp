#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include scripts\utils;
#include scripts\main;
#include scripts\functions;


menuinit()
{
    self.menu = SpawnStruct();
    self.hud = SpawnStruct();
    self.menu.isopen = false;
    self.smoothscroll = false;
    self.scrolly = -100;
    self structure();
    self thread buttons();
}



buttons()
{
    self endon("death");
    while(true)
    {
        if(!self.menu.isopen)
        {
            if(self adsbuttonpressed() && self isButtonPressed("+actionslot 1"))
            {
                self.menu.isopen = true;
                self MenuHud();
                self load_menu("main");
                self notify("menuopened");
                wait 0.1;
            }
        }
        else
        {
            if(self isButtonPressed("+actionslot 1"))
            {
                self.scroll--;
                self UpdateScroll();
                wait .1;
            }
            
            if(self isButtonPressed("+actionslot 2"))
            {
                self.scroll++;
                self UpdateScroll();

                wait .1;
            }
            
            if(self usebuttonpressed())
            { 
                self ExecuteFunction(self.menu.func[self.menu.current][self.scroll],self.menu.input[self.menu.current][self.scroll],self.menu.input2[self.menu.current][self.scroll]);
                self notify("selectedoption");    
                self structure();
                self load_menu(self.menu.current);    
                wait .2;
            }
            
            if(self meleebuttonpressed())
            {
                if(self.menu.parent[self.menu.current] == "exit")
                {
                    self DestroyHud();
                    self.menu.isopen = false;
                    self notify("closedmenu");
                }
                else
                {
                    self load_menu(self.menu.parent[self.menu.current]);
                    waitframe();
                }

                wait .2;
            }
        }
        waitframe();
    }
}

UpdateScroll()
{
    if ( self.scroll < 0 )
        self.scroll = self.menu.text[self.menu.current].size - 1;

    if ( self.scroll > self.menu.text[self.menu.current].size - 1 )
        self.scroll = 0;

    if ( !isdefined( self.menu.text[self.menu.current][self.scroll - 5] ) || self.menu.text[self.menu.current].size <= 10 )
    {
        for ( i = 0; i < 10; i++ )
        {
            if ( isdefined( self.menu.text[self.menu.current][i] ) )
                self.hud.option[i] = self.menu.text[self.menu.current][i];
            else
                self.hud.option[i] = "";
        }

        self.hud.scroll.y = -97 + (9.65 * self.scroll);

        


    }
    else if ( isdefined( self.menu.text[self.menu.current][self.scroll + 5] ) )
    {
        index = 0;

        for ( i = self.scroll - 5; i < self.scroll + 5; i++ )
        {
            if ( isdefined( self.menu.text[self.menu.current][i] ) )
                self.hud.option[index] = self.menu.text[self.menu.current][i];
            else
                self.hud.option[index] = "  ";
            index++;

        }

        self.hud.scroll.y = -97 + (9.65 * 5);

    }
    else
    {
        for ( i = 0; i < 10; i++ )
        {
            self.hud.option[i] = self.menu.text[self.menu.current][self.menu.text[self.menu.current].size + i - 10];
        }

        self.hud.scroll.y = -97 + 9.65 * ( self.scroll - self.menu.text[self.menu.current].size + 10 );

    }
    self.hud.text SetText(self.hud.option[0] + "\n" + self.hud.option[1] + "\n" + self.hud.option[2] + "\n" + self.hud.option[3] + "\n" + self.hud.option[4] + "\n" + self.hud.option[5] + "\n" + self.hud.option[6] + "\n" + self.hud.option[7] + "\n" + self.hud.option[8] + "\n" + self.hud.option[9]);
    countoverflow(self.hud.option[0] + "\n" + self.hud.option[1] + "\n" + self.hud.option[2] + "\n" + self.hud.option[3] + "\n" + self.hud.option[4] + "\n" + self.hud.option[5] + "\n" + self.hud.option[6] + "\n" + self.hud.option[7] + "\n" + self.hud.option[8] + "\n" + self.hud.option[9]);
    
}

menuhud()
{
    self.hud.background = self createRectangle("TOP", "CENTER", 185, -130, 170, 200, (0,0,0), 0.9, 0, "white");
    self.hud.scroll = self createRectangle("TOP", "CENTER", 185, -97, 180, 11, (0,0.390,0.590), 1, 1, "white");
    self.hud.leftbar = self createRectangle("TOP", "CENTER", 95, -131, 2, 200, (0,0.390,0.590), 0.9, 1, "white");
    self.hud.rightbar = self createRectangle("TOP", "CENTER", 275, -131, 2, 200, (0,0.390,0.590), 0.9, 1, "white");
    self.hud.middlebar = self createRectangle("TOP", "CENTER", 185, -102, 180, 2, (0,0.390,0.590), 1, 1, "white");
    self.hud.topbar = self createRectangle("TOP", "CENTER", 185, -131, 180, 2, (0,0.390,0.590), 1, 1, "white");
    self.hud.bottombar = self createRectangle("TOP", "CENTER", 185, -131, 180, 2, (0,0.390,0.590), 1, 1, "white");
    self.hud.menutitle = self createText("default", 1, "CENTER", "CENTER", 180, -115, 2, (1,1,1), 1, "^4SafeFail");
    self.hud.text = self createText("default", 0.8, "LEFT", "CENTER", 100, -91, 2, (1,1,1), 1, "placeholder");
}

updabackground()
{
    count = self.menu.text[self.menu.current].size;
    if(count > 10)
    count = 10;
    self.hud.background SetShader("white", 180, 38 + ( count * 10 ));
    self.hud.leftbar SetShader("white", 2, 40 + ( count * 10 ));
    self.hud.rightbar SetShader("white", 2, 40 + ( count * 10 ));
    self.hud.bottombar.y =  -93 + (count * 10);
}


destroyhud()
{
    self.hud.background destroy();
    self.hud.middlebar destroy();
    self.hud.topbar destroy();
    self.hud.rightbar destroy();
    self.hud.leftbar destroy();
    self.hud.bottombar destroy();
    self.hud.scroll Destroy();
    self.hud.menutitle destroy();
    self.hud.text Destroy();
}


Structure()
{
    self create_menu("main", "exit");
    self add_option("main",  "Misc", ::load_menu,undefined,"Misc");
    self add_option("main",  "Toggles", ::load_menu,undefined,"Toggles");
    self add_option("main",  "Aimbot", ::load_menu,undefined,"Aimbot");
    self add_option("main",  "Weapons", ::load_menu,undefined,"Weapons");
    self add_option("main",  "Binds", ::load_menu,undefined,"Binds");
    self add_option("main",  "Killstreaks", ::load_menu,undefined,"Killstreaks");
    self add_option("main",  "Perks", ::load_menu,undefined,"Perks");
    self add_option("main",  "Lobby", ::load_menu,undefined,"Lobby");
    self add_option("main",  "Players", ::load_menu,undefined,"Players");

    self create_menu("Misc", "main");
    self add_option("Misc","Give Vish", ::givevish);
    self add_option("Misc","Spawn Bounce", ::spawnbounce);
    self add_option("Misc","Delete Bounce", ::deletebounce);
    self add_option("Misc","Give Cowboy", ::givecowboy);
    self add_option("Misc","Spawn Helicopter", ::spawnheli);
    self add_option("Misc","Delete Helicopter", ::deleteheli);

    self create_menu("Binds", "main");
    self add_option("Binds","Nac Mod", ::load_menu,undefined,"Nac Mod");
    self add_option("Binds","Instaswap", ::load_menu,undefined,"Instaswap");
    self add_option("Binds","CCB", ::load_menu,undefined,"CCB");
    self add_option("Binds","Bolt Movement", ::load_menu,undefined,"Bolt Movement");
    self add_option("Binds","Scavenger", ::load_menu,undefined,"Scavenger");
    self add_option("Binds","Velocity", ::load_menu,undefined,"Velocity");
    self add_option("Binds","Equipment", ::load_menu,undefined,"Equipment");
    self add_option("Binds","Animations", ::load_menu,undefined,"Animations");
    self add_option("Binds","OMA", ::load_menu,undefined,"OMA");
    self add_bind("Binds","Canswap",::canswapbind,"canswap");
    self add_bind("Binds","Illusion Canswap",::illusioncanswapbind,"illusioncanswap");
    self add_bind("Binds","Illusion",::illusionbind,"illusion");
    self add_bind("Binds","Altswap",::altswapbind,"altswap");
    self add_bind("Binds","Houdini",::houdinibind,"houdini");
    self add_bind("Binds","Mala",::malabind,"mala");
    self add_bind("Binds","Hitmarker",::hitmarkerbind,"hitmarker");
    self add_bind("Binds","Damage",::damagebind,"damage");
    self add_bind("Binds","Fake Odin",::odinbind,"odin");
    self add_bind("Binds","Pred Vision",::predvisionbind,"predvision");
    self add_bind("Binds","Static Vision",::staticvisionbind,"staticvision");
    self add_bind("Binds","Gryphon Vision",::gryphonvisionbind,"gryphonvision");
    self add_bind("Binds","EMP",::empbind,"emp");
    self add_bind("Binds","Flash",::flashbind,"flash");
    self add_bind("Binds","STZ Tilt",::stztiltbind,"stztiltbind");
    self add_bind("Binds","Gunlock",::gunlockbind,"gunlock");
    self add_bind("Binds","Jspin",::jspinbind,"jspin");
    self add_bind("Binds","Carepackage Stall",::carepackstallbind,"carepackstall");
    self add_bind("Binds","Links Jitter",::linksjitterbind,"linksjitter");

    self create_menu("OMA", "Binds");
    self add_option("OMA","Bar Time", ::changeomatime,"[" + getdvarfloat("omatime") + "]");
    self add_bind("OMA","OMA Bar",::omabarbind,"omabar");
    self add_bind("OMA","OMA Shax",::omashaxbind,"omashax");
    self add_bind("OMA","OMA Sprint",::omasprintbind,"omasprint");

    self create_menu("Equipment", "Binds");
    self add_option("Equipment","Weapon", ::changeeqbindweap,"[" + getdvar("eqbindweap") + "]");
    self add_option("Equipment","Putaway", ::toggleeqbindputaway,getdvar("eqbindputaway"));
    self add_bind("Equipment","Bind",::eqbind,"eqbind");

    self create_menu("Velocity", "Binds");
    self add_option("Velocity","Dvar -> velocity", ::veloplaceholder);
    self add_bind("Velocity","Bind",::velocitybind,"velocitybind");

    self create_menu("Animations", "Binds");
    self add_bind("Animations","Sprint In",::sprintinbind,"sprintin");
    self add_bind("Animations","Sprint Loop",::sprintloopbind,"sprintloop");
    self add_bind("Animations","Slide",::slidebind,"slide");
    self add_bind("Animations","Glide",::glidebind,"glide");
    self add_bind("Animations","Reload",::reloadbind,"reload");
    self add_bind("Animations","Empty Reload",::emptyreloadbind,"emptyreload");
    self add_bind("Animations","Melee",::meleebind,"melee");
    self add_bind("Animations","Lunge",::lungebind,"lunge");
    self add_bind("Animations","Mantle",::mantlebind,"mantle");
    self add_bind("Animations","Smooth",::smoothbind,"smooth");

    self create_menu("Bolt Movement", "Binds");
    self add_option("Bolt Movement","Save Point", ::savebolt);
    self add_option("Bolt Movement","Delete Point", ::deletebolt,"[" + getDvarInt("function_boltcount") + "]");
    self add_option("Bolt Movement","Speed", ::boltspeed,"[" + getDvarfloat("bolttime") + "]");
    self add_bind("Bolt Movement","Bind",::boltbind,"bolt");
    self add_option("Bolt Movement","Record Movement", ::record_movement);
    self add_option("Bolt Movement","Remove Last Point", ::removepoint,"[" + self.pers["movpos"] + "]");
    self add_bind("Bolt Movement","Play Movement",::playmovementbind,"playmovementbind");

    self create_menu("CCB", "Binds");
    self add_bind("CCB","Bind",::changeclassbind,"ccb");
    self add_option("CCB","Wrap Limit", ::changeccblimit,"[" + getdvarint("ccblimit") + "]");
    self add_option("CCB","Canswaps", ::toggleccbcanswap,getdvar("ccbcanswap"));

    self create_menu("Instaswap", "Binds");
    self add_option("Instaswap","First Weapon", ::selectfirstinstaswap,"[" + getdvar("firstweaponinstaswapname") + "]");
    self add_option("Instaswap","Second Weapon", ::selectsecondinstaswap,"[" + getdvar("secondweaponinstaswapname") + "]");
    self add_bind("Instaswap","Bind",::instaswapbind,"instaswap");

    self create_menu("Nac Mod", "Binds");
    self add_option("Nac Mod","First Weapon", ::selectfirstnac,"[" + getdvar("firstweaponnacname") + "]");
    self add_option("Nac Mod","Second Weapon", ::selectsecondnac,"[" + getdvar("secondweaponnacname") + "]");
    self add_bind("Nac Mod","Bind",::nacbind,"nac");

    self create_menu("Scavenger", "Binds");
    self add_bind("Scavenger","Bind",::scavengerbind,"scavenger");
    self add_option("Scavenger","Real Scavenger", ::togglerealscavenger,getdvar("realscavenger"));


    self create_menu("Aimbot", "main");
    self add_option("Aimbot",  "Aimbot",::toggleaimbot,getdvar("aimbot"));
    self add_option("Aimbot",  "Aimbot Weapon",::selectaimbotweapon,"[" + getdvar("aimbot_weapon_name") + "]");
    self add_option("Aimbot",  "Aimbot Range",::changeaimbotrange,"[" + getdvarint("aimbot_range") + "]");
    self add_option("Aimbot",  "Hitmarker Aimbot",::togglehitmarkeraimbot,getdvar("hitmarkeraimbot"));
    self add_option("Aimbot",  "Hitmarker Aimbot Weapon",::hitmarkeraimbotweapon,"[" + getdvar("hitmarkeraimbotweaponname") + "]");
    self add_option("Aimbot",  "Equipment Aimbot",::eqaimbot,getdvar("eqaimbot"));
    self add_option("Aimbot",  "Equipment Aimbot Weapon",::selecteqaimbotweapon,"[" + getdvar("eqaimbotweaponname") + "]");

    self create_menu("Lobby", "main");
    self add_option("Lobby",  "Spawn Bot",::SpawnBot);
    self add_option("Lobby",  "Kick Bots",::kickbots);
    self add_option("Lobby",  "Bots To Crosshair",::botstoch);
    self add_option("Lobby",  "Bots Look At Me",::botslookatme);
    self add_option("Lobby",  "Gravity",::changegravity,"[" + getdvarint("g_gravity") + "]");
    self add_option("Lobby",  "Move Speed",::changemovespeed,"[" + getdvarint("g_speed") + "]");
    self add_option("Lobby",  "Timescale",::changetimescale,"[" + getdvarfloat("pantimescale") + "]");

    self create_menu("Toggles", "main");
    self add_option("Toggles",  "God Mode",::togglegodmode,getdvar("godmode"));
    self add_option("Toggles",  "Noclip Bind",::toggleufobind,getdvar("ufobind"));
    if(getdvar("alwayscanswap") != "specific")
    self add_option("Toggles",  "Always Canswap",::togglealwayscanswap,getdvar("alwayscanswap"));
    else
    self add_option("Toggles",  "Always Canswap",::togglealwayscanswap,"[" + getdvar("canswapweaponname") + "]");

    self add_option("Toggles",  "Smooth Canswaps",::togglesmoothcanswaps,getdvar("smoothcanswaps"));
    self add_option("Toggles",  "Smooth Canswap Wait Time",::changesmoothcanswapwait,"[" + getdvarfloat("smoothcanswapwait") + "]");

    self add_option("Toggles",  "Instashoot",::toggleinstashoots,getdvar("instashoot"));


    if(getdvar("instashootweapon") == "[ALL]")
    self add_option("Toggles",  "Instashoot Weapon",::toggleinstashootweapon,getdvar("instashootweapon"));
    else
    self add_option("Toggles",  "Instashoot Weapon",::toggleinstashootweapon,"[" + getdvar("instashootweaponname") + "]");

    self add_option("Toggles",  "STZ Tilt",::togglestztilt,getdvar("stztilt"));
    self add_option("Toggles",  "Head Bounces",::toggleheadbounces,getdvar("headbounces"));
    self add_option("Toggles",  "Instaswaps",::toggleeqswap,getdvar("eqswap"));
    self add_option("Toggles",  "Instant Equipment",::toggleinstaeq,getdvar("instaeq"));
    self add_option("Toggles",  "Use Radius",::togglepickupradius,getdvar("dapickup"));
    self add_option("Toggles",  "Infinite Equipment",::toggleinfeq,getdvar("infeq"));

    self create_menu("Weapons", "main");
    self add_option("Weapons",  "Refill Ammo", ::refillammo);
    self add_option("Weapons",  "Drop Weapon", ::dropdagun);
    self add_option("Weapons",  "Take Weapon", ::takedaweapon);
    self add_option("Weapons",  "Assault Rifles", ::load_menu,undefined,"Assault Rifles");
    self add_option("Weapons",  "Sub Machine Guns", ::load_menu,undefined,"Sub Machine Guns");
    self add_option("Weapons",  "Light Machine Guns", ::load_menu,undefined,"Light Machine Guns");
    self add_option("Weapons",  "Sniper Rifles", ::load_menu,undefined,"Sniper Rifles");
    self add_option("Weapons",  "Marksman Rifles", ::load_menu,undefined,"Marksman Rifles");
    self add_option("Weapons",  "Shotguns", ::load_menu,undefined,"Shotguns");
    self add_option("Weapons",  "Handguns", ::load_menu,undefined,"Handguns");
    self add_option("Weapons",  "Launchers", ::load_menu,undefined,"Launchers");
    self add_option("Weapons",  "Specials", ::load_menu,undefined,"Specials");

    self create_menu("Specials", "Weapons");
    self add_option("Specials",  "Bomb", ::givedaweapon,undefined,"briefcase_bomb_mp");
    self add_option("Specials",  "Gold Knife", ::givedaweapon,undefined,"iw6_knifeonlyfast_mp");
    self add_option("Specials",  "Riot Shield", ::givedaweapon,undefined,"iw6_riotshield_mp");
    self add_option("Specials",  "Normal Knife", ::givedaweapon,undefined,"iw6_knifeonly_mp");
    self add_option("Specials",  "Minigun", ::givedaweapon,undefined,"iw6_minigunjugg_mp");
    self add_option("Specials",  "Laptop", ::givedaweapon,undefined,"killstreak_predator_missile_mp");
    self add_option("Specials",  "Phone", ::givedaweapon,undefined,"killstreak_uav_3dping_mp");
    self add_option("Specials",  "Whistle", ::givedaweapon,undefined,"killstreak_guard_dog_mp");

    self create_menu("Launchers", "Weapons");
    self add_option("Launchers",  "Kastet", ::givedaweapon,undefined,"iw6_rgm_mp");
    self add_option("Launchers",  "Panzerfaust", ::givedaweapon,undefined,"iw6_panzerfaust3_mp");
    self add_option("Launchers",  "MK32", ::givedaweapon,undefined,"iw6_mk32_mp");
    self add_option("Launchers",  "MAAWS", ::givedaweapon,undefined,"iw6_maaws_mp");

    self create_menu("Handguns", "Weapons");
    self add_option("Handguns",  "M9A1", ::givedaweapon,undefined,"iw6_m9a1_mp");
    self add_option("Handguns",  "MP-443 Grach", ::givedaweapon,undefined,"iw6_mp443_mp");
    self add_option("Handguns",  "P226", ::givedaweapon,undefined,"iw6_p226_mp");
    self add_option("Handguns",  ".44 Magnum", ::givedaweapon,undefined,"iw6_magnum_mp");
    self add_option("Handguns",  "PDW", ::givedaweapon,undefined,"iw6_pdw_mp");
    self add_option("Handguns",  "Gold PDW", ::givedaweapon,undefined,"iw6_pdwauto_mp");


    self create_menu("Light Machine Guns", "Weapons");
    self add_option("Light Machine Guns",  "Ameli", ::givedaweapon,undefined,"iw6_ameli_mp");
    self add_option("Light Machine Guns",  "M27-IAR", ::givedaweapon,undefined,"iw6_m27_mp");
    self add_option("Light Machine Guns",  "LSAT", ::givedaweapon,undefined,"iw6_lsat_mp");
    self add_option("Light Machine Guns",  "Chain SAW", ::givedaweapon,undefined,"iw6_kac_mp");

    self create_menu("Marksman Rifles", "Weapons");
    self add_option("Marksman Rifles",  "MR-28", ::givedaweapon,undefined,"iw6_g28_mp_g28scope");
    self add_option("Marksman Rifles",  "MK14 EBR", ::givedaweapon,undefined,"iw6_mk14_mp_mk14scope");
    self add_option("Marksman Rifles",  "IA-2", ::givedaweapon,undefined,"iw6_imbel_mp_imbelscope");
    self add_option("Marksman Rifles",  "SVU", ::givedaweapon,undefined,"iw6_svu_mp_svuscope");

    self create_menu("Shotguns", "Weapons");
    self add_option("Shotguns",  "Bulldog", ::givedaweapon,undefined,"iw6_maul_mp_griphide");
    self add_option("Shotguns",  "FP6", ::givedaweapon,undefined,"iw6_fp6_mp_grip");
    self add_option("Shotguns",  "MTS-255", ::givedaweapon,undefined,"iw6_mts255_mp_griphide");
    self add_option("Shotguns",  "TAC 12", ::givedaweapon,undefined,"iw6_uts15_mp_grip");

    self create_menu("Sniper Rifles", "Weapons");
    self add_option("Sniper Rifles",  "USR", ::givedaweapon,undefined,"iw6_usr_mp_usrscope");
    self add_option("Sniper Rifles",  "Lynx", ::givedaweapon,undefined,"iw6_gm6_mp_gm6scope");
    self add_option("Sniper Rifles",  "L115", ::givedaweapon,undefined,"iw6_l115a3_mp_l115a3scope");
    self add_option("Sniper Rifles",  "VKS", ::givedaweapon,undefined,"iw6_vks_mp_vksscope");
    self add_option("Sniper Rifles",  "Maverick", ::givedaweapon,undefined,"iw6_dlcweap03_mp_dlcweap03scope");

    self create_menu("Sub Machine Guns", "Weapons");
    self add_option("Sub Machine Guns",  "Ripper", ::givedaweapon,undefined,"iw6_dlcweap02_mp_dlcweap02scope");
    self add_option("Sub Machine Guns",  "Bizon", ::givedaweapon,undefined,"iw6_pp19_mp");
    self add_option("Sub Machine Guns",  "CBJ-MS", ::givedaweapon,undefined,"iw6_cbjms_mp");
    self add_option("Sub Machine Guns",  "Vector CRB", ::givedaweapon,undefined,"iw6_kriss_mp");
    self add_option("Sub Machine Guns",  "Vepr", ::givedaweapon,undefined,"iw6_vepr_mp");
    self add_option("Sub Machine Guns",  "K7", ::givedaweapon,undefined,"iw6_k7_mp");
    self add_option("Sub Machine Guns",  "MTAR-X", ::givedaweapon,undefined,"iw6_microtar_mp");

    self create_menu("Assault Rifles", "Weapons");
    self add_option("Assault Rifles",  "Maverick", ::givedaweapon,undefined,"iw6_dlcweap01_mp");
    self add_option("Assault Rifles",  "SC-2010", ::givedaweapon,undefined,"iw6_sc2010_mp");
    self add_option("Assault Rifles",  "SA-805", ::givedaweapon,undefined,"iw6_bren_mp");
    self add_option("Assault Rifles",  "AK-12", ::givedaweapon,undefined,"iw6_ak12_mp");
    self add_option("Assault Rifles",  "FAD", ::givedaweapon,undefined,"iw6_fads_mp");
    self add_option("Assault Rifles",  "Remmington R5", ::givedaweapon,undefined,"iw6_r5rgp_mp");
    self add_option("Assault Rifles",  "MSBS", ::givedaweapon,undefined,"iw6_msbs_mp");
    self add_option("Assault Rifles",  "Honey Badger", ::givedaweapon,undefined,"iw6_honeybadger_mp");
    self add_option("Assault Rifles",  "ARX-160", ::givedaweapon,undefined,"iw6_arx160_mp");

    self create_menu("Killstreaks", "main");
    self add_option("Killstreaks",  "Support", ::load_menu,undefined,"Support");
    self add_option("Killstreaks",  "Assault", ::load_menu,undefined,"Assault");
    self add_option("Killstreaks",  "Nuke", ::pankillstreak,undefined,"nuke");
    self add_option("Killstreaks",  "Care Package", ::pankillstreak,undefined,"airdrop_assault");
    self add_option("Killstreaks",  "Map Streak", ::mapstreak);
    self add_option("Killstreaks",  "Fill Streaks", ::fillstreaks);

    self create_menu("Support", "Killstreaks");
    for(i=0;i<level.pansupportks.size;i++)
    self add_option("Support",  level.pansupportks[i], ::pankillstreak,undefined,level.pansupportks2[i]);

    self create_menu("Assault", "Killstreaks");
    for(i=0;i<level.panassaultks.size;i++)
    self add_option("Assault",  level.panassaultks[i], ::pankillstreak,undefined,level.panassaultks2[i]);

    self create_menu("Perks", "main");
    foreach(perk in level.panperks)
    self add_option("Perks",  perk,::givedaperk,undefined,perk);


    self create_menu("Players", "main");
    foreach(player in level.players)
    {
        self add_option("Players",  player.name, ::load_menu,undefined,player.name);
        self create_menu(player.name, "Players");
        self add_option(player.name, "Kick", ::kickdumbass,undefined,player);
        self add_option(player.name, "To Crosshair", ::playertocrosshair,undefined,player);
        self add_option(player.name, "Helicopter Sniper", ::playersniper,undefined,player);
    }
}


