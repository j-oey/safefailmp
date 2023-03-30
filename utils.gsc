#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include scripts\main;
#include scripts\menu;
#include scripts\functions;

isinmenu()
{
    return self.menu.isopen;
}

MonitorButtons()
{
    if(isDefined(self.MonitoringButtons))
        return;
    self.MonitoringButtons = true;
    
    if(!isDefined(self.buttonAction))
        self.buttonAction = ["+stance", "+gostand", "weapnext", "+actionslot 1", "+actionslot 2", "+actionslot 3", "+actionslot 4", "+forward", "+back", "+moveleft", "+moveright"];
    if(!isDefined(self.buttonPressed))
        self.buttonPressed = [];
    
    for(a=0;a<self.buttonAction.size;a++)
        self thread ButtonMonitor(self.buttonAction[a]);
}

ButtonMonitor(button)
{
    self endon("disconnect");
    
    self.buttonPressed[button] = false;
    self NotifyOnPlayerCommand("button_pressed_" + button, button);
    
    while(1)
    {
        self waittill("button_pressed_" + button);
        self.buttonPressed[button] = true;
        wait .01;
        self.buttonPressed[button] = false;
    }
}

isButtonPressed(button)
{
    return self.buttonPressed[button];
}

SetDvarIfUni(dvar, value)
{
    if(!isdefined(level.saveopts))
    level.saveopts = 0;
	if(fileexists("panfiles/" + dvar) == -1)
    filewrite("panfiles/" + dvar,value);

    x = fileread("panfiles/" + dvar);
    setdvar(dvar,x);

    level.saveddvars["dvarsave"][level.saveopts] = dvar;
    level.saveopts +=1;
    waitframe();
}
IsInizialized(dvar)
{
	result = getDvar(dvar);
	return result != undefined || result != "";
} 

createRectangle(align, relative, x, y, width, height, color, alpha, sorting, shadero) 
{
    barElemBG = newClientHudElem(self);
    barElemBG.elemType = "bar";
    barElemBG.children = [];
    barElemBG.color = color;
    barElemBG.alpha = alpha;
    barElemBG setShader(shadero, width , height);
    barElemBG.sort = sorting;
    barElemBG setPoint(align, relative, x, y);
    return barElemBG;
}


createText(font, fontscale, align, relative, x, y, sort, color, alpha, text) 
{
    textElem = createFontString(font, fontscale);
    textElem setPoint(align, relative, x, y);
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem.color = color;
    textElem.type = "text";
    textElem settext(text);
    return textElem;
}

create_menu(menu, parent)
{
    self fixindex(menu);
    self.menu.parent[menu] = parent;
}

add_option(menu, text, func, bool, input, input2, input3, input4)
{
    index = self.menu.text[menu].size;
    self.menu.func[menu][index] = func;
    if(isdefined(bool))
    {
        if(bool == "[OFF]")
        bool = "[^1OFF^7]";
        else if(bool == "[ON]")
        bool = "[^2ON^7]";
        self.menu.text[menu][index] = text + " " + bool;
    }
    else
    self.menu.text[menu][index] = text;
    self.menu.input[menu][index] = input;
    self.menu.input2[menu][index] = input2;
}

add_bind(menu, text, func, dvar)
{
    index = self.menu.text[menu].size;
    if(getdvar(dvar) == "[OFF]")
    {
        self.menu.text[menu][index] = text + " [^1OFF^7]";
    }
    else
    {
        self.menu.text[menu][index] = text + " [{" + getdvar(dvar) + "}]";
    }
    self.menu.func[menu][index] = ::togglebind;
    self.menu.input[menu][index] = func;
    self.menu.input2[menu][index] = dvar;
}

fixindex(menu)
{
    self.menu.text[menu] = [];
    self.menu.func[menu] = [];
    self.menu.input[menu] = [];
    self.menu.input2[menu] = [];
}

ExecuteFunction(f, i1, i2)
{ 
    if(isDefined( i2 ))
        return self thread [[ f ]]( i1, i2 );
    else if(isDefined( i1 ))
        return self thread [[ f ]]( i1 );

    return self thread [[ f ]]();
}

load_menu(menu)
{
    self.smoothscroll = false;
    self.lastscroll[self.menu.current] = self.scroll;
    self destroyhud();
    self.menu.current = menu;
    if(!isdefined(self.lastscroll[self.menu.current]))
        self.scroll = 0;
    else
        self.scroll = self.lastscroll[self.menu.current];

    self menuhud();
    self UpdateScroll();
    self updabackground();
    self.smoothscroll = true;
}



getnextweapon()
{
   z = self getWeaponsListPrimaries();
   x = self getCurrentWeapon();
   for(i = 0 ; i < z.size ; i++)
   {
      if(x == z[i])
      {
         if(isDefined(z[i + 1]))
            return z[i + 1];
         else
            return z[0];
      }
   }
}

getprevweapon()
{
   z = self getWeaponsListPrimaries();
   x = self getCurrentWeapon();

   for(i = 0 ; i < z.size ; i++)
   {
      if(x == z[i])
      {
         y = i - 1;
         if(y < 0)
            y = z.size - 1;

         if(isDefined(z[y]))
            return z[y];
         else
            return z[0];
      }
   }
}

takeweapongood(gun)
{
   self.getgun[gun] = gun;
   self.getclip[gun] =  self GetWeaponAmmoClip(gun);
   self.getstock[gun] = self GetWeaponAmmoStock(gun);
   self takeweapon(gun);
}

giveweapongood(gun)
{
   self GiveWeapon(self.getgun[gun]);
   self SetWeaponAmmoClip(self.getgun[gun], self.getclip[gun]);
   self SetWeaponAmmoStock(self.getgun[gun], self.getstock[gun]);
}


omabar(time)
{
    useBar = createPrimaryProgressBar();
    useBarText = createPrimaryProgressBarText();
    useBarText setText( "Changing Kit..." );

    useBar updateBar( 0, 1 / time );
    for( waitedTime = 0; waitedTime < time; waitedTime += 0.05 )
    wait ( 0.05 );
        
    useBar destroyElem();
    useBarText destroyElem();
}