package liteAssets.draw
{
   import fl.controls.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import liteAssets.listOptionsItem.listKeybind;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2220")]
   public class keybinds extends MovieClip
   {
      
      public var a1:MovieClip;
      
      public var btnClose:SimpleButton;
      
      public var a2:MovieClip;
      
      public var txtSearch:TextField;
      
      public var cntMask:MovieClip;
      
      public var frame:MovieClip;
      
      public var bg:MovieClip;
      
      public var btnReset:SimpleButton;
      
      public var SBar:MovieClip;
      
      public var optObj:*;
      
      public var optItem:*;
      
      public var Len:*;
      
      public var optionList:*;
      
      public var hRun:Number;
      
      public var dRun:Number;
      
      public var oy:Number;
      
      public var mDown:Boolean;
      
      public var mbY:int;
      
      public var mbD:int;
      
      public var mhY:int;
      
      public var pos:int;
      
      public var i:int;
      
      public var optionGet:Array;
      
      private var toolTip:*;
      
      internal var r:MovieClip;
      
      internal var sDown:Boolean;
      
      public function keybinds(param1:MovieClip)
      {
         super();
         this.r = param1;
         this.x = 480.3;
         this.y = 259.35;
         toolTip = param1.ui.ToolTip;
         initOptions();
         redraw(optionGet);
         SBar.h.addEventListener(MouseEvent.MOUSE_DOWN,onScrDown,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,onScrUp,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel,false,0,true);
         optionList.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
         optionList.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
         txtSearch.addEventListener(Event.CHANGE,onSearch,false,0,true);
         btnClose.addEventListener(MouseEvent.CLICK,onClose,false,0,true);
         btnReset.addEventListener(MouseEvent.CLICK,onReset,false,0,true);
      }
      
      public function onReset(param1:MouseEvent) : void
      {
         var _loc3_:* = undefined;
         r.initKeybindPref(true);
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc3_ = r.ui.mcInterface.getChildByName("keyA" + _loc2_);
            _loc3_.text = (_loc2_ + 1).toString();
            _loc3_.mouseEnabled = false;
            _loc2_++;
         }
         this.parent.removeChild(this);
      }
      
      public function initOptions() : void
      {
         optionGet = [{
            "strName":"Camera Tool",
            "sDesc":"Launches Camera Tool"
         },{
            "strName":"World Camera",
            "sDesc":"Launches World Camera"
         },{
            "strName":"Target Random Monster",
            "sDesc":"Targets a random monster in your room if available"
         },{
            "strName":"Inventory",
            "sDesc":"Opens your inventory"
         },{
            "strName":"Bank",
            "sDesc":"Opens the bank if you have a bank pet or bank cape in your inventory"
         },{
            "strName":"Quest Log",
            "sDesc":"Opens your quest log where you can turn in your completed quests"
         },{
            "strName":"Friends List",
            "sDesc":"Opens your friends list"
         },{
            "strName":"Character Panel",
            "sDesc":"Opens the character panel"
         },{
            "strName":"Player HP Bar",
            "sDesc":"Toggles the appearance of an HP bar above all player heads"
         },{
            "strName":"Options",
            "sDesc":"Opens the options"
         },{
            "strName":"Area List",
            "sDesc":"Opens up the /who list that shows who\'s in the map"
         },{
            "strName":"Jump",
            "sDesc":"Makes your player do the jump animation"
         },{
            "strName":"Auto Attack",
            "sDesc":"Activates the attack that every class knows"
         },{
            "strName":"Skill 1",
            "sDesc":"Actives the first skill of your class if available"
         },{
            "strName":"Skill 2",
            "sDesc":"Actives the second skill of your class if available"
         },{
            "strName":"Skill 3",
            "sDesc":"Actives the third skill of your class if available"
         },{
            "strName":"Skill 4",
            "sDesc":"Actives the fourth skill of your class if available"
         },{
            "strName":"Skill 5",
            "sDesc":"Actives the potion slot if available"
         },{
            "strName":"Travel Menu\'s Travel",
            "sDesc":"The keybind used to travel to the next map in the list for the Travel Menu"
         },{
            "strName":"World Camera\'s Hide",
            "sDesc":"The keybind used to hide the World Camera\'s ui"
         },{
            "strName":"Rest",
            "sDesc":"Your character will start resting to restore HP / MP"
         },{
            "strName":"Hide Monsters",
            "sDesc":"Toggles the hide monsters function located on your player portrait"
         },{
            "strName":"Hide Players",
            "sDesc":"Toggles the hide players feature"
         },{
            "strName":"Cancel Target",
            "sDesc":"Cancels your target if available. Cooldown is your auto attack speed. (Has a minimum cooldown of 2 seconds)"
         },{
            "strName":"Hide UI",
            "sDesc":"Hides portraits and map information located on the bottom right"
         },{
            "strName":"Battle Analyzer",
            "sDesc":"Launches Battle Analyzer"
         },{
            "strName":"Decline All Drops",
            "sDesc":"Declines all the drops on your screen. Be very cautious when binding this to a key"
         },{
            "strName":"Stats Overview",
            "sDesc":"Toggle the Stats Panel/Overview!"
         },{
            "strName":"Battle Analyzer Toggle",
            "sDesc":"Toggles the Start/Stop of Battle Analyzer"
         },{
            "strName":"Custom Drops UI",
            "sDesc":"Toggles the visibility of Custom Drops UI"
         },{
            "strName":"@ Debugger - Cell Menu",
            "sDesc":"Toggles the visibility of the Cell Menu"
         },{
            "strName":"@ Debugger - Packet Logger",
            "sDesc":"Toggles the visibility of the Packet Logger"
         },{
            "strName":"Dash",
            "sDesc":"After activating this keybind, your next movement click will be a dash."
         },{
            "strName":"Outfits",
            "sDesc":"Opens the Outfits interface"
         },{
            "strName":"Friendships UI",
            "sDesc":"Opens the Friendships UI interface"
         }];
      }
      
      public function onClose(param1:MouseEvent) : void
      {
         this.parent.removeChild(this);
         r.stage.focus = null;
      }
      
      public function onOver(param1:MouseEvent) : void
      {
         try
         {
            if(!param1.target.parent.sDesc)
            {
               return;
            }
            toolTip.openWith({"str":param1.target.parent.sDesc});
         }
         catch(e:*)
         {
         }
      }
      
      public function onOut(param1:MouseEvent) : *
      {
         toolTip.close();
      }
      
      public function orderName(param1:*, param2:*) : int
      {
         var _loc3_:* = param1["strName"];
         var _loc4_:* = param2["strName"];
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public function redraw(param1:Array) : void
      {
         var _loc2_:* = undefined;
         SBar.h.y = 0;
         if(optionList != null)
         {
            this.removeChild(optionList);
            optionList = null;
         }
         optionList = this.addChild(new MovieClip());
         Len = param1.length;
         param1.sort(orderName);
         i = 0;
         var _loc3_:* = 0;
         while(i < Len)
         {
            optObj = param1[i];
            if(optObj.strName.indexOf("@ Debugger") != -1)
            {
               if(Game.objLogin.iAccess < 30)
               {
                  i += 1;
                  continue;
               }
            }
            optItem = new listKeybind(r,r.litePreference.data.keys[optObj.strName],optObj.sDesc);
            optItem.txtName.text = optObj.strName;
            _loc2_ = optionList.addChild(optItem);
            _loc2_.x = cntMask.x;
            _loc2_.y = cntMask.y + 35 * _loc3_;
            _loc2_.addEventListener(MouseEvent.MOUSE_OVER,onOver,false,0,true);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,onOut,false,0,true);
            ++i;
            _loc3_++;
         }
         optionList.mask = cntMask;
         mDown = false;
         hRun = SBar.b.height - SBar.h.height;
         dRun = optionList.height - cntMask.height + 5;
         oy = optionList.y;
         optionList.addEventListener(Event.ENTER_FRAME,hEF,false,0,true);
         optionList.addEventListener(Event.ENTER_FRAME,dEF,false,0,true);
      }
      
      public function onSearch(param1:Event) : void
      {
         initOptions();
         var _loc2_:Number = 0;
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         while(_loc4_ < optionGet.length)
         {
            if(optionGet[_loc4_].strName.toLowerCase().indexOf(txtSearch.text.toLowerCase()) > -1)
            {
               _loc3_.push(optionGet[_loc4_]);
               _loc2_ += optionGet[_loc4_].extra ? 1 + optionGet[_loc4_].extra.length : 1;
            }
            _loc4_++;
         }
         if(_loc2_ <= 9)
         {
            SBar.h.removeEventListener(MouseEvent.MOUSE_DOWN,onScrDown);
            this.removeEventListener(MouseEvent.MOUSE_UP,onScrUp);
            this.removeEventListener(MouseEvent.MOUSE_WHEEL,onWheel);
         }
         else if(_loc2_ > 9 && !SBar.h.hasEventListener(MouseEvent.MOUSE_DOWN))
         {
            SBar.h.addEventListener(MouseEvent.MOUSE_DOWN,onScrDown,false,0,true);
            this.addEventListener(MouseEvent.MOUSE_UP,onScrUp,false,0,true);
            this.addEventListener(MouseEvent.MOUSE_WHEEL,onWheel,false,0,true);
         }
         redraw(!txtSearch.text ? optionGet : _loc3_);
         _loc3_ = null;
      }
      
      public function onWheel(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         _loc2_ = SBar;
         _loc2_.h.y = int(SBar.h.y) + param1.delta * 3 * -1;
         if(_loc2_.h.y + _loc2_.h.height > _loc2_.b.height)
         {
            _loc2_.h.y = int(_loc2_.b.height - _loc2_.h.height);
         }
         if(_loc2_.h.y < 0)
         {
            _loc2_.h.y = 0;
         }
      }
      
      public function onScrDown(param1:MouseEvent) : *
      {
         mbY = int(mouseY);
         mhY = int(SBar.h.y);
         mDown = true;
      }
      
      public function onScrUp(param1:MouseEvent) : void
      {
         mDown = false;
      }
      
      public function hEF(param1:Event) : *
      {
         var _loc2_:* = undefined;
         if(mDown)
         {
            _loc2_ = SBar;
            mbD = int(mouseY) - mbY;
            _loc2_.h.y = mhY + mbD;
            if(_loc2_.h.y + 1 + _loc2_.h.height > _loc2_.b.height + 1)
            {
               _loc2_.h.y = int(_loc2_.b.height + 1 - _loc2_.h.height);
            }
            if(_loc2_.h.y < 1)
            {
               _loc2_.h.y = 1;
            }
         }
      }
      
      public function dEF(param1:Event) : *
      {
         var _loc2_:* = SBar;
         var _loc3_:* = optionList;
         var _loc4_:* = -(_loc2_.h.y - 1) / hRun;
         var _loc5_:* = int(_loc4_ * dRun) + oy;
         if(Math.abs(_loc5_ - _loc3_.y) > 0.2)
         {
            _loc3_.y += (_loc5_ - _loc3_.y) / 4;
         }
         else
         {
            _loc3_.y = _loc5_;
         }
      }
   }
}

